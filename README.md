# tam
tamasomā jyotir gamaya - From darkness, lead me to light

Contains some handy bash/shell init scripts for quick reference, when you are in shell !

When you login via ssh on a remote machine, you might want a quick help of your familiar commands.
This remote machine is not a dev machine that you will login every day, hence setting up a required
shortcuts via shell source file is not done yet as you might be logging in for the first time!

Now, imagine for debugging issues you might want to ssh random hosts and need quick help
without switching to a another wondow, how handy would that be?

TAM is aimed to solve the problem of setting up your own custom shell environment
upon ssh!

The idea is very simple - ship the required init scripts by bas64 encoding and
start bash session with created init file.

```bash
TAMI="/path/to/tami.sh"
function s()
{
	# You can append as many source files as you wnat here
	INIT=`cat $TAMI /some/other/bashrc.sh | base64`
	SSH_CMD="echo $INIT>/tmp/init64; base64 --decode /tmp/init64>/tmp/init; bash --init-file /tmp/init"
	ssh -t <user>@<hostname> "${SSH_CMD}"
}
```