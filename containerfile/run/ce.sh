set -o nounset
set -o errexit
set -o pipefail

NUM_CPUS=12
TMPDIR=/tmp
export DEBIAN_FRONTEND=noninteractive

# update apt
apt-get -qq update

# need nodejs and npm
apt-get -qq install nodejs npm

# many Python libraries
pip install ipython notebook jupyterlab voila
pip install jupyterlab-git jupyterlab_hdf #jupyterlab_sql
pip install python-rclone
pip install python-dateutil compress-pickle sqlitedict pipenv
pip install google-api-python-client google-cloud-logging google-auth google-cloud-bigquery google-cloud-logging google-cloud-storage google-cloud-firestore db-dtypes
pip install gspread gspread-pandas pydrive boto3 pynamodb oauth2client oauthlib
pip install requests requests_oauthlib lxml beautifulsoup4
pip install yattag jinja2
#pip install dash dash_daq dash-google-auth jupyter-plotly-dash dash-bootstrap-components dash_flexbox_grid click click-plugins cligj
pip install plotly bokeh pandas_bokeh seaborn altair ggplot
pip install sqlalchemy dask ray modin joblib tables #h5netcdf xarray
pip install holoviews['recommended'] datashader hvplot panel param colorcet intake intake-parquet #pyviz
pip install panel param colorcet intake
pip install progressbar2 tqdm psutil
#pip install speedtest-cli
#pip install cadquery
pip install statsmodels scikit-image networkx nose pytest
#pip install pywavelets python-picard mne git+https://github.com/mne-tools/mne-features
#pip install antropy
#pip install tensorflow
#pip install torch==1.9.0+cpu torchvision==0.10.0+cpu torchaudio==0.9.0 -f https://download.pytorch.org/whl/torch_stable.html
#apt-get -qq install libbz2-dev liblzma-dev # pyreadr compile needs
#pip install feedparser pyreadr --no-binary pyreadr
#pip install python-gitlab gcip canvasapi
#pip install datalad biopython kaggle
#apt-get -qq install swig
#pip install pymde cvxpy
#pip install snuggs hy

# sys utils
# apt-get -qq install htop iftop iotop multitail
# # network tools
# echo "debconf krb5-config/default_realm stanford.edu" > debconf-set-selections
# apt-get -qq install openssl curl mosh stunnel net-tools dnsutils traceroute whois iputils-arping iputils-clockdiff iputils-ping iputils-tracepath inetutils-ftp inetutils-telnet lftp fping iperf tcpdump nmap netcat libpcap-dev libzmq5 krb5-user
# pip install pyzmq git+https://github.com/vpiserchia/pypcap
# # related dev tools
# #apt-get -qq install git-annex
# # ngrok
# wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O /tmp/ngrok.tgz
# tar xvzf /tmp/ngrok.tgz -C /usr/local/bin

# document processing
#pip install fpdf
#apt-get -qq install texlive texlive-science pandoc ghostscript

# audo/image/video tools
apt-get -qq install libavcodec-extra libavfilter-extra ffmpeg imagemagick libtiff-dev #libgdal-dev
pip install scikit-image imageio pillow tifffile pytiff #rasterio
#pip install av pims ffmpeg-python
pip install opencv-contrib-python-headless
#pip install vapoursynth - needs manual compile/install

# google cloud sdk
apt-get -qq install apt-transport-https ca-certificates gnupg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-cloud.gpg] https://packages.cloud.google.com/apt cloud-sdk main" > /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg > /usr/share/keyrings/google-cloud.gpg
apt-get -qq update
apt-get -qq install google-cloud-sdk google-cloud-sdk-app-engine-python google-cloud-sdk-app-engine-python-extras

# cloud_sql_proxy
wget https://dl.google.com/cloudsql/cloud_sql_proxy.linux.amd64 -O /usr/local/bin/cloud_sql_proxy
chmod 755 /usr/local/bin/cloud_sql_proxy

# coder/code-server
wget -qO - https://raw.githubusercontent.com/coder/code-server/main/install.sh | bash

# containers
#apt-get -qq install podman

# heroku
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/heroku.gpg] http://toolbelt.heroku.com/ubuntu ./" > /etc/apt/sources.list.d/heroku.list
#curl https://toolbelt.heroku.com/apt/release.key | gpg --dearmor > /usr/share/keyrings/heroku.gpg
#apt-get -qq update
#apt-get -qq install heroku-toolbelt

# cleanup
apt-get -qq autoremove
apt-get -qq clean
pip cache purge
