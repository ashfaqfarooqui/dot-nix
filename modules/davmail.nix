{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    jdk11
    openjfx11
    davmail

  ];

#  home.file.".davmail.properties".source = ../configs/davmail/.davmail.properties;
}
