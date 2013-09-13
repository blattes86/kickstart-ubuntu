#!/bin/sh

echo "Sélectionner l'interface graphique de votre choix"
#variable pour le comptage dans la boucle
i=1
#pour choix "ubuntu" "kubuntu" "xubuntu" "lubuntu"; alors
for choix in "ubuntu" "kubuntu" "xubuntu" "lubuntu"; do
	#écrire numéro ) choix
	echo  $i")" $choix
	#on rajoute un à chaque tour de boucle
	i=$(($i+1))
done
#saisi du choi
echo "#? : "; read choi
# tant que $choi n'est pas égale a 1 2 3 ou 4; alors
while [ $choi -ne "1" ] && [ $choi -ne "2" ] && [ $choi -ne "3" ] && [ $choi -ne "4" ]; do
	#on affiche une erreur
	echo "saisie non valide !"
	#et on ressaisi le choi
	echo "#? : "; read choi
done
#ici on teste les choix et on effectue des actions en fonctions de ce choi
if [ $choi = 1 ]
then
	echo "ubuntu" > /tmp/graph_choi
	echo "@ubuntu-desktop" > /tmp/pre_package
	exit
elif [ $choi = 2 ]
then
	echo "kubuntu" > /tmp/graph_choi
	echo "@kubuntu-desktop" > /tmp/pre_package
	exit
elif [ $choi = 3 ]
then
	echo "xubuntu" > /tmp/graph_choi
	echo "@xubuntu-desktop" > /tmp/pre_package
	exit
elif [ $choi = 4 ]
then
	echo "lubuntu" > /tmp/graph_choi
	echo "@lubuntu-desktop" > /tmp/pre_package
	exit
fi
