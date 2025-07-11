#
# Building a Docker Image with
# the Latest Ubuntu Version and
# Basic Python Install
# 
# Python for Algorithmic Trading
# (c) Dr. Yves J. Hilpisch
# The Python Quants GmbH
#

# latest Ubuntu version
FROM ubuntu:latest  

# information about maintainer
LABEL maintainer="yves"

# add the bash script
COPY install.sh /install.sh

# change rights & run the script（同じレイヤーで）
RUN chmod +x /install.sh && /bin/bash /install.sh

# prepend the new path
ENV PATH=/root/miniconda3/bin:$PATH

# execute IPython when container is run
CMD ["ipython"]