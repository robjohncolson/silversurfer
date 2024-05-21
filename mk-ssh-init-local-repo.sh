echo "navigate webbrowser to URL:"
echo "create repo silversurfer"
read -p "press enter, when ready"

git config --global user.email "robjohncolson@protonmail.com"
git config --global user.name "robert colson"
echo "navigate web browser to URL:"
echo "https://github.com/settings/keys"

echo "copy the ssh key below:"

ssh-keygen -t ed25519 -C "robjohncolson@protonmail.com" && eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_ed25519 && cat ~/.ssh/id_ed25519.pub


read -p "press enter, when ready to initialize this directory as the silversurfer repo"

echo "# silversurfer" >> README.md && git init && git add README.md && git commit -m "first commit" && git branch -M main && git remote add origin git@github.com:robjohncolson/silversurfer.git && git push -u origin main
