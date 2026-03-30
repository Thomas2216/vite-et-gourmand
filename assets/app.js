import "./styles/app.css";

import "@hotwired/turbo";

import {startStimulusApp} from "@symfony/stimulus-bundle";

const app = startStimulusApp();


const btnAddItem = document.getElementById("btn-add-item");
const menuList = document.getElementById("menu-list");
const totalPrix = document.getElementById("prix-total");
const selectMenus = document.getElementById("liste-menus-a-selectionner");
const itemId = selectMenus.value;

btnAddItem.addEventListener("click", async () => {


    try {
        const reponse = await fetch('/add_menu', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                itemId: itemId,
                action: 'add'
            })
        });

        if (!reponse.ok) {
            throw new Error("Erreur serveur :" + reponse.status);
        }

        const data = await reponse.json();
        if (totalPrix) {
            totalPrix.textContent = data.totalPrix + " €";
        }

        console.log("Succès ! Nouveau total :", data.totalPrix);

        menuList.innerHTML = await reponse.json();

        menuList.style.display = "block";

    } catch (erreur) {
        menuList.innerHTML = `<strong>Oups !</strong> Impossible de récupérer les données.<br><small>${erreur.message}</small>`;
        menuList.style.display = 'block';
        menuList.style.color = '#d9534f';

        console.error("Détail complet de l'erreur :", erreur);
        }
});
