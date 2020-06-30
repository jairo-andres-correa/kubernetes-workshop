#! /bin/sh
tmux has-session -t kubernetes
if [ $? != 0 ]
then
  tmux new-session -s kubernetes -n control -d
  tmux send-keys -t kubernetes 'gcloud beta compute ssh "control" --ssh-flag="-A"' C-m
  tmux split-window -v -t kubernetes
  tmux send-keys -t kubernetes:1.2 'gcloud beta compute ssh "worker1" --ssh-flag="-A"' C-m
  tmux split-window -h -t kubernetes
  tmux send-keys -t kubernetes:1.3 'gcloud beta compute ssh "worker2" --ssh-flag="-A"' C-m
  tmux select-layout -t kubernetes main-horizontal
  tmux select-window -t kubernetes:1
fi
tmux attach -t kubernetes
