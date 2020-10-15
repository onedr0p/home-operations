<h1 align="center">
  My home Kubernetes cluster :sailboat:
  <br />
  <br />
  <img src="https://i.imgur.com/p1RzXjQ.png">
</h1>
<br />
<div align="center">

[![Discord](https://img.shields.io/badge/discord-chat-7289DA.svg?maxAge=60&style=flat-square)](https://discord.gg/DNCynrJ) [![GitHub stars](https://img.shields.io/github/stars/onedr0p/home-operations?color=green&style=flat-square)](https://github.com/onedr0p/home-operations/stargazers) [![GitHub issues](https://img.shields.io/github/issues/onedr0p/home-operations?style=flat-square)](https://github.com/onedr0p/home-operations/issues) [![GitHub last commit](https://img.shields.io/github/last-commit/onedr0p/home-operations?color=purple&style=flat-square)](https://github.com/onedr0p/home-operations/commits/master)

</div>

---

# :book:&nbsp; Overview

Highly opinionated Ansible playbooks, Ansible roles, and other things that are used to maintain my homelab.

## :computer:&nbsp; Hardware configuration

_All my Kubernetes master and worker nodes below are running bare metal Ubuntu 20.04.x_

| Device                  | Count | OS Disk Size | Data Disk Size      | Ram  | Purpose                       |
|-------------------------|-------|--------------|---------------------|------|-------------------------------|
| Intel NUC8i3BEK         | 3     | 256GB NVMe   | N/A                 | 16GB | Kubernetes k3s Masters        |
| Intel NUC8i5BEH         | 3     | 120GB SSD    | 1TB NVMe (longhorn) | 32GB | Kubernetes k3s Workers        |
| Intel NUC8i7BEH         | 2     | 750GB SSD    | 1TB NVMe (longhorn) | 64GB | Kubernetes k3s Workers        |
| Qnap NAS (rocinante)    | 1     | N/A          | 8x12TB RAID6        | 16GB | Media and shared file storage |
| Synology NAS (serenity) | 1     | N/A          | 8x12TB RAID6        | 4GB  | Media and shared file storage |

---