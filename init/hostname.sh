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
    sudo sh -c "echo aspen1 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.7")
    sudo sh -c "echo aspen2 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.8")
    sudo sh -c "echo aspen3 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.9")
    sudo sh -c "echo aspen4 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.10")
    sudo sh -c "echo worker1 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.11")
    sudo sh -c "echo worker2 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.12")
    sudo sh -c "echo worker3 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.13")
    sudo sh -c "echo worker4 > /etc/hostname" ; sudo init 6
    ;;
  "10.1.1.14")
    sudo sh -c "echo worker5 > /etc/hostname" ; sudo init 6
    ;;

esac
