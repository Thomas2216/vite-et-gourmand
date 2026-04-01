import "./styles/app.css";
import "@hotwired/turbo";
import { startStimulusApp } from "@symfony/stimulus-bundle";

const app = startStimulusApp();

const btnAddItem = document.getElementById("btn-add-item");
const menuList = document.getElementById("menu-list");
const totalPrix = document.getElementById("prix-total");
const selectMenus = document.getElementById("liste-menus-a-selectionner");

function rafraichirPanier(data) {
    if (totalPrix) {
        totalPrix.textContent = "Total : " + data.totalPrix + " €";
    }

    menuList.innerHTML = '';

    if (data.detailPanier && data.detailPanier.length > 0) {
        data.detailPanier.forEach(item => {
            const li = document.createElement('li');
            li.innerHTML = `${item.titre} - ${item.prix} x${item.quantite} = ${item.sousTotal} €
                            <button class="btn-rm-item" data-menu-id="${item.menuId}">X</button>`;
            menuList.appendChild(li);
        });
    }

    menuList.style.display = "block";
}

btnAddItem.addEventListener("click", async () => {
    const menuId = selectMenus.value;

    try {
        const reponse = await fetch('/add_menu', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ menuId: menuId, action: 'add' })
        });

        if (!reponse.ok) throw new Error("Erreur serveur : " + reponse.status);

        const data = await reponse.json();
        rafraichirPanier(data);

    } catch (erreur) {
        menuList.innerHTML = `<strong>Oups !</strong> Impossible d'ajouter le menu.<br><small>${erreur.message}</small>`;
        menuList.style.display = 'block';
        menuList.style.color = '#d9534f';
        console.error("Détail complet de l'erreur :", erreur);
    }
});

menuList.addEventListener("click", async (e) => {
    if (!e.target.classList.contains("btn-rm-item")) return;

    const menuId = e.target.dataset.menuId;

    try {
        const reponse = await fetch('/add_menu', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ menuId: menuId, action: 'remove' })
        });

        if (!reponse.ok) throw new Error("Erreur serveur : " + reponse.status);

        const data = await reponse.json();
        rafraichirPanier(data);

    } catch (erreur) {
        menuList.innerHTML = `<strong>Oups !</strong> Impossible de supprimer le menu.<br><small>${erreur.message}</small>`;
        menuList.style.display = 'block';
        menuList.style.color = '#d9534f';
        console.error("Détail complet de l'erreur :", erreur);
    }
});
