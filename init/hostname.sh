#!/usr/bin/env bash

IP_ADDRESS=$(hostname -I | cut -d' ' -f1)

case ${IP_ADDRESS} in

  "10.1.1.4")
    sudo sh -c "echo jumphost > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.5")
    sudo sh -c "echo master > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.6")
    sudo sh -c "echo node1 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.7")
    sudo sh -c "echo node2 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.8")
    sudo sh -c "echo node3 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.9")
    sudo sh -c "echo node4 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.10")
    sudo sh -c "echo node5 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.11")
    sudo sh -c "echo node6 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.12")
    sudo sh -c "echo node7 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.13")
    sudo sh -c "echo node8 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.14")
    sudo sh -c "echo node9 > /etc/hostname" ; sudo init 6
    ;;

esac
