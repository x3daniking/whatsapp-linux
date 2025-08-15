#!/bin/bash

# Script to switch between HTTPS and SSH for GitHub remote

echo "WhatsApp Linux - Git Remote Helper"
echo ""

current_remote=$(git remote get-url origin)
echo "Current remote: $current_remote"
echo ""

if [[ $current_remote == https* ]]; then
    echo "Switching to SSH..."
    git remote set-url origin git@github.com:x3daniking/whatsapp-linux.git
    echo "✅ Switched to SSH: git@github.com:x3daniking/whatsapp-linux.git"
    echo ""
    echo "⚠️  Make sure you have SSH keys set up:"
    echo "   - Generate: ssh-keygen -t ed25519 -C 'your_email@example.com'"
    echo "   - Add to GitHub: cat ~/.ssh/id_ed25519.pub"
    echo "   - Test: ssh -T git@github.com"
else
    echo "Switching to HTTPS..."
    git remote set-url origin https://github.com/x3daniking/whatsapp-linux.git
    echo "✅ Switched to HTTPS: https://github.com/x3daniking/whatsapp-linux.git"
fi

echo ""
echo "New remote: $(git remote get-url origin)"
