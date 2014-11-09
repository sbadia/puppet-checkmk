#!/bin/bash

check_mk_version="$1"
check_mk_agent="check-mk-agent_${check_mk_version}_all.deb"
check_mk_agent_logwatch="check-mk-agent-logwatch_${check_mk_version}_all.deb"
check_mk_agent_url="http://mathias-kettner.com.sixxs.org/download/${check_mk_agent}"
check_mk_agent_logwatch_url="http://mathias-kettner.com.sixxs.org/download/${check_mk_agent_logwatch}"

wget $check_mk_agent_url 
wget $check_mk_agent_logwatch_url 
