# We will start with an extremely basic image and expand on it later
FROM alpine:latest

RUN apk add --no-cache \
    openssh \
    openssh-client \
    netcat-openbsd \
    vim \
    busybox-extras  # includes telnet

# Create SSH directory and enable server
RUN mkdir -p /var/run/sshd && \
    ssh-keygen -A

# Set root password for testing
# KILL THIS FOR PROD PLEASE
# RUN echo 'root:root' | chpasswd

# Allow root login
RUN sed -i 's/#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

EXPOSE 22

# Make sure sshd is actually running
CMD ["/usr/sbin/sshd", "-D"]
