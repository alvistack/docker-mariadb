# (c) Wong Hoi Sing Edison <hswong3i@pantarei-design.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM mariadb:10.4

ENV POD_NAMESPACE "default"

ENTRYPOINT [ "dumb-init", "--", "docker-entrypoint.sh" ]
CMD        [ "mysqld" ]

# Prepare APT dependencies
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y curl htop less patch vim wget \
    && rm -rf /var/lib/apt/lists/*

# Install dumb-init
RUN set -ex \
    && curl -skL https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 > /usr/local/bin/dumb-init \
    && echo "c16e45a301234c732af4c38be1e1000a2ce1cba8 /usr/local/bin/dumb-init" | sha1sum -c - \
    && chmod 0755 /usr/local/bin/dumb-init

# Install peer-finder
RUN set -ex \
    && curl -skL https://storage.googleapis.com/kubernetes-release/pets/peer-finder > /usr/local/bin/peer-finder \
    && echo "5abfeabdd8c011ddf6b0abf33011c5866ff7eb39 /usr/local/bin/peer-finder" | sha1sum -c - \
    && chmod 0755 /usr/local/bin/peer-finder

# Copy files
COPY files /
