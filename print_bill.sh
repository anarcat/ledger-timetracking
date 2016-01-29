#!/bin/sh

bill=$1
receivables='assets:receivables'
timeentries='revenues:client'

echo "Invoice notes"
echo "-------------"
echo
ledger -f ledger.lgr --uncleared --format '%(date) %b %(justify(truncated(payee, int(payee_width)), int(payee_width))) %(justify(scrub(display_amount), int(amount_width)))\n'   register $timeentries

echo
echo
echo "Invoice balance"
echo "---------------"
echo 
ledger -f ledger.lgr --uncleared --limit "payee=~/invoice #$bill/" --format 'cost? %P(display_amount) ? %(justify(truncated(payee, int(payee_width)), int(payee_width))) %(justify(scrub(display_amount), int(amount_width)))\n'   register $receivables

echo "missing:"
echo "- rates"
echo "- addresses"
echo "- notes"
