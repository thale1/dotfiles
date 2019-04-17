import subprocess

FLAGS = []
ROCKYJS_TEST_FLAGS = []

def append_arglist(arglist, args=None,
                   pre=None, post=None,
                   item_pre=None, item_post=None, item_sep=None):
    if pre:
        arglist.extend(pre.split())
    def append_item(item):
        parts = item.split()
        if not parts:
            return
        if item_pre:
            arglist.append(item_pre)
        arglist.extend(parts)
        if item_post:
            arglist.append(item_post)
        if item_sep:
            arglist.append(item_sep)
    for arg in args.split() if isinstance(args, str) else args:
        append_item(arg)
    if item_sep:
        del arglist[-1]
    if post:
        arglist.extend(post.split())
    return arglist


def make_arglist(*args, **kwargs):
    return append_arglist([], *args, **kwargs)


def call(args=None, **kwargs):
    return subprocess.Popen(' '.join(append_arglist([], args=args, **kwargs)), shell=True, stdout=subprocess.PIPE).stdout.read()


def append_warnings(arglist, args):
    append_arglist(arglist, [ '-W{warn} -Werror={warn}'.format(warn=arg) for arg in args ])


def append_includes(arglist, *args, **kwargs):
    append_arglist(arglist, item_pre='-I', *args, **kwargs)


def append_find_paths(arglist, args, find_type, flag):
    append_arglist(arglist, call(pre='find . -type {find_type} \\('.format(find_type=find_type),
                                 args=args.split('\n'),
                                 item_sep='-o',
                                 post='\\)'),
                   item_pre=flag)


def append_find_includes(arglist, args):
    append_find_paths(arglist, args, find_type='d', flag='-I')


def append_find_inline_includes(arglist, args):
    append_find_paths(arglist, args, find_type='f', flag='-include')


def FlagsForFile(filename, **kwargs):
    flags = (['-x', 'c', '-std=c99'] if filename.endswith('.c') else
             ['-x', 'c++']) + FLAGS
    if 'rockyjs/test' in filename:
        flags.extend(ROCKYJS_TEST_FLAGS)
    return { 'flags': flags }


# product/gcc/Makefile
append_arglist(FLAGS, [
    '-ffunction-sections -fdata-sections -fomit-frame-pointer -mfloat-abi=hard -fshort-enums -fdiagnostics-color=auto',
    '-target arm',
    '-DFX_INCLUDE_USER_DEFINE_FILE',
    '-DTX_INCLUDE_USER_DEFINE_FILE',
    '-DWITH_SDL2',
    '-DWITH_MACOSX'])

append_includes(FLAGS, [
    call('arm-none-eabi-gcc --print-file-name=include'),
    call('arm-none-eabi-gcc --print-file-name=include-fixed')])

# product/gcc/project_parsery.py
warning_as_error_list = [ 'discarded-qualifiers', 'return-type',
                          'implicit-function-declaration',
                          'incompatible-pointer-types' ]

append_warnings(FLAGS, warning_as_error_list)

append_find_includes(FLAGS, """
    -name common
    -name inc
    -iname include
    -path "*/inc/*"

    -name threadx_iar_570
    -path "*/{product}/iar"

    -name build_algo_library
    -name fb_driver_api
    -name fb_mcu_drivers_api

    -path "*/fb_public_api/*"

    -name 'glue'
    -path "*/koru/source/*"
    -path "*/koru/source/glui/*"
    -path "*/koru/source/glui/libglui/*"

    -name jerryscript
    -path "*/jerry-core/*"
    -path "*/rockyjs/src"
    -path "*/rockyjs/src/api"
    -path "*/rockyjs/src/api/*"
    -path "*/rockyjs/src/platform/{platform}"

    -name fb_vos
    -name fb_vos_desktop
    -path "*/fb_vos_desktop/mock_thread"
    """.format(platform='bison', product='boson'))

append_find_inline_includes(FLAGS, """
    -path "*/jerryscript/jerry-config.h"
    -path "*/rockyjs/src/platform/{platform}/rocky_config.h"
    """.format(platform='bison', product='boson'))

append_find_includes(ROCKYJS_TEST_FLAGS, """
    -path "*/rockyjs/tests"
    -path "*/rockyjs/tests/*"
    """)

print('\n'.join(FLAGS))
