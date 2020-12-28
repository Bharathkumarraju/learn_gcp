bharath@cloudshell:~ (bharathpoc)$ export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"
~>
-->

-->gcloud auth login
Go to the following link in your browser:

    https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=32555940559.apps.googleusercontent.com&redirect_uri=urn%3Aietf%3Awg%3Aoauth%3A2.0%3Aoob&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&state=i22koMoajlxnzEffGMpcXllXQpfXk1&prompt=consent&access_type=offline&code_challenge=tR2Pr-7blfLiU41xLJ34rkyO8FmwCr3OLUwohbWa3Tw&code_challenge_method=S256

Enter verification code: 4/1AY0e-g4jGy4WiUDrZD9YOiWPjPO7F7IdnoJn8OD1kdwlwjpJ1YKvXilBFZo

You are now logged in as [bharath@bharathkumaraju.com].
Your current project is [bharathpoc].  You can change this setting by running:
  $ gcloud config set project PROJECT_ID
~>
-->


-->gcloud config set project bharathpoc
Updated property [core/project].
~>
-->gcloud config list
[component_manager]
disable_update_check = True
[compute]
gce_metadata_read_timeout_sec = 30
[core]
account = bharath@bharathkumaraju.com
disable_usage_reporting = True
project = bharathpoc
[metrics]
environment = devshell

Your active configuration is: [cloudshell-24818]
~>
-->

-->cd bharath_gae_code/bharath-greetings/
~/bharath_gae_code/bharath-greetings>
-->ls -rtlh
total 12K
-rw-r--r-- 1 bharath bharath  12 Dec 28 10:51 requirements.txt
-rw-r--r-- 1 bharath bharath 219 Dec 28 10:56 app.yaml
-rw-r--r-- 1 bharath bharath 195 Dec 28 10:56 main.py
~/bharath_gae_code/bharath-greetings>
-->pwd
/home/bharath/bharath_gae_code/bharath-greetings
~/bharath_gae_code/bharath-greetings>
-->

~/bharath_gae_code/bharath-greetings>
-->sudo pip3 install -r requirements.txt
Collecting Flask==1.0.2 (from -r requirements.txt (line 1))
  Using cached https://files.pythonhosted.org/packages/7f/e7/08578774ed4536d3242b14dacb4696386634607af824ea997202cd0edb4b/Flask-1.0.2-py2.py3-none-any.whl
Requirement already satisfied: itsdangerous>=0.24 in /usr/local/lib/python3.7/dist-packages (from Flask==1.0.2->-r requirements.txt (line 1)) (1.1.0)
Requirement already satisfied: click>=5.1 in /usr/local/lib/python3.7/dist-packages (from Flask==1.0.2->-r requirements.txt (line 1)) (7.0)
Requirement already satisfied: Werkzeug>=0.14 in /usr/local/lib/python3.7/dist-packages (from Flask==1.0.2->-r requirements.txt (line 1)) (1.0.1)
Requirement already satisfied: Jinja2>=2.10 in /usr/local/lib/python3.7/dist-packages (from Flask==1.0.2->-r requirements.txt (line 1)) (2.11.2)
Requirement already satisfied: MarkupSafe>=0.23 in /usr/local/lib/python3.7/dist-packages (from Jinja2>=2.10->Flask==1.0.2->-r requirements.txt (line 1)) (1.1.1)
Installing collected packages: Flask
  Found existing installation: Flask 1.1.2
    Uninstalling Flask-1.1.2:
      Successfully uninstalled Flask-1.1.2
Successfully installed Flask-1.0.2
~/bharath_gae_code/bharath-greetings>
-->

Local_RUN:
------------------------>

-->dev_appserver.py app.yaml
********************************************************************************
Python 2 is deprecated. Upgrade to Python 3 as soon as possible.
See https://cloud.google.com/python/docs/python2-sunset

To suppress this warning, create an empty ~/.cloudshell/no-python-warning file.
The command will automatically proceed in  seconds or on any key.
********************************************************************************
INFO     2020-12-28 11:13:05,253 devappserver2.py:289] Skipping SDK update check.
WARNING  2020-12-28 11:13:05,513 simple_search_stub.py:1198] Could not read search indexes from /tmp/appengine.None.bharath/search_indexes
INFO     2020-12-28 11:13:05,514 api_server.py:282] Starting API server at: http://localhost:35785
INFO     2020-12-28 11:13:05,521 instance_factory.py:121] Detected Python 3.7.3

The virtual environment was not created successfully because ensurepip is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

    apt-get install python3-venv

You may need to use sudo with that command.  After installing the python3-venv
package, recreate your virtual environment.

Failing command: ['/tmp/tmpyybD0f/bin/python3', '-Im', 'ensurepip', '--upgrade', '--default-pip']

created virtual environment CPython3.7.3.final.0-64 in 683ms
  creator CPython3Posix(dest=/tmp/tmpyybD0f, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/home/bharath/.local/share/virtualenv)
    added seed packages: pip==20.3.1, setuptools==51.0.0, wheel==0.36.1
-->dev_appserver.py app.yaml
********************************************************************************
Python 2 is deprecated. Upgrade to Python 3 as soon as possible.
See https://cloud.google.com/python/docs/python2-sunset

To suppress this warning, create an empty ~/.cloudshell/no-python-warning file.
The command will automatically proceed in  seconds or on any key.
********************************************************************************
INFO     2020-12-28 11:13:05,253 devappserver2.py:289] Skipping SDK update check.
WARNING  2020-12-28 11:13:05,513 simple_search_stub.py:1198] Could not read search indexes from /tmp/appengine.None.bharath/search_indexes
INFO     2020-12-28 11:13:05,514 api_server.py:282] Starting API server at: http://localhost:35785
INFO     2020-12-28 11:13:05,521 instance_factory.py:121] Detected Python 3.7.3

The virtual environment was not created successfully because ensurepip is not
available.  On Debian/Ubuntu systems, you need to install the python3-venv
package using the following command.

    apt-get install python3-venv

You may need to use sudo with that command.  After installing the python3-venv
package, recreate your virtual environment.

Failing command: ['/tmp/tmpyybD0f/bin/python3', '-Im', 'ensurepip', '--upgrade', '--default-pip']

created virtual environment CPython3.7.3.final.0-64 in 683ms
  creator CPython3Posix(dest=/tmp/tmpyybD0f, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, setuptools=bundle, wheel=bundle, via=copy, app_data_dir=/home/bharath/.local/share/virtualenv)
    added seed packages: pip==20.3.1, setuptools==51.0.0, wheel==0.36.1
  activators BashActivator,CShellActivator,FishActivator,PowerShellActivator,PythonActivator,XonshActivator
INFO     2020-12-28 11:13:06,557 instance_factory.py:255] Using pip to install dependency libraries; pip stdout is redirected to /tmp/tmpr0CzpX
INFO     2020-12-28 11:13:06,561 instance_factory.py:261] Running /tmp/tmpyybD0f/bin/pip install --upgrade pip

INFO     2020-12-28 11:13:12,952 instance_factory.py:261] Running /tmp/tmpyybD0f/bin/pip install -r /tmp/tmp3s3Jtb

INFO     2020-12-28 11:13:14,947 dispatcher.py:267] Starting module "default" running at: http://localhost:8080
INFO     2020-12-28 11:13:14,948 admin_server.py:150] Starting admin server at: http://localhost:8000
INFO     2020-12-28 11:13:15,949 instance.py:557] Detected GOOGLE_CLOUD_PROJECT=bharathpoc in environment variables
[2020-12-28 11:13:16 +0000] [17139] [INFO] Starting gunicorn 20.0.4
[2020-12-28 11:13:16 +0000] [17139] [INFO] Listening at: http://0.0.0.0:19234 (17139)
[2020-12-28 11:13:16 +0000] [17139] [INFO] Using worker: sync
[2020-12-28 11:13:16 +0000] [17143] [INFO] Booting worker with pid: 17143
[2020-12-28 11:13:16 +0000] [17139] [INFO] Handling signal: winch
INFO     2020-12-28 11:13:16,961 instance.py:294] Instance PID: 17139
INFO     2020-12-28 11:13:17,064 module.py:432] [default] Detected file changes:
  /home/bharath/bharath_gae_code/bharath-greetings/__pycache__
[2020-12-28 11:13:17 +0000] [17139] [INFO] Handling signal: winch

