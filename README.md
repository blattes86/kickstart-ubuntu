kickstart-ubuntu
================

un fichier kickstart (normalement compatible toutes version et toutes interface graphique) et tout ce qui va avec créé pour l'association ALIS 44

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!ATTENTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!Les scripts sont fournits en l'état!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!Ils ne sont absolument pas fait pour une !!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!utilisation externe à l'association ALIS 44!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!Il faudra que vous les adaptiez a !!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!votre configuration!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

fichier présent:

2 fichier ks.cfg : Ils font le même travail, la différence réside dans le fait qu'il y ait un fichier qui fasse un partitionnement automatique ( ks_avec_partitionnement.cfg ):
 - si le disque fait plus de 40 Go
	512 Mo de swap en primaire
	12 GO pour la racine en ext4 primaire
	le reste pour le /home en ext4 primaire
	
 - si le disque fait moins de 40 Go
	512 Mo de swap en primaire
	le reste pour la racine en ext4 primaire

script_pre.sh : un simple script qui permet de choisir quel interface graphique nous voulons installer (U|KU|XU|LU)buntu
	
xubuntu.cfg : un fichier preseed fonctionnant en complément du fichier ks permettant l'installation de xfce 4.10 sur la precise
	
ubuntu-post.sh : script permettant de rajoutter des dépôt, de mettre à jour, d'installer et de supprimer une certaine quantité de logiciel de manière automatique au premier démarage de la machine
