FROM ubuntu:latest
RUN apt update
RUN apt install sniproxy dnsmasq iptables -y
ADD dnsmasq.conf /etc/dnsmasq.tpl
ADD sniproxy.conf /etc/sniproxy.conf
RUN ln -sf /dev/stdout /var/log/sniproxy/sniproxy.log
EXPOSE 53/udp
EXPOSE 80
EXPOSE 443
ENV IP SERVER_IP
CMD sed "s/{IP}/${IP}/" /etc/dnsmasq.tpl > /etc/dnsmasq.conf && \
dnsmasq -khR & sniproxy -c /etc/sniproxy.conf -f
