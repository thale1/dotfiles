#!/bin/bash

WEBHOOK_URL=https://outlook.office.com/webhook/116bead0-71c6-404b-b08f-5bb0115cb69b@c12007a4-882b-4381-b05a-b783431570c7/IncomingWebhook/40ca33f28aa048279e3d99f926e4db89/c4e1c1ec-0625-4f8b-8ff1-4169c31ac248

teams-chat-post.sh $WEBHOOK_URL "$HOSTNAME did something" "red" "Check on me"
