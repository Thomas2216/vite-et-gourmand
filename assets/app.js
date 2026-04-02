import "./styles/app.css";
import "@hotwired/turbo";
import { startStimulusApp } from "@symfony/stimulus-bundle";

const app = startStimulusApp();

document.addEventListener("turbo:load", () => {

    const btnAddItem       = document.getElementById("btn-add-item");
    const menuList         = document.getElementById("menu-list");
    const totalPrix        = document.getElementById("prix-total");
    const selectMenus      = document.getElementById("liste-menus-a-selectionner");
    const adresseInput     = document.getElementById('commande_adresse');
    const fraisLivraisonEl = document.getElementById('frais-livraison');

    if (!btnAddItem || !menuList || !selectMenus || !adresseInput) return;

    const BORDEAUX_COORDS = [44.8378, -0.5792];

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

        const optionSelectionnee = selectMenus.options[selectMenus.selectedIndex];
        const minPersonne        = parseInt(optionSelectionnee.dataset.minPersonne);
        const nombrePersonnes    = parseInt(document.getElementById('commande_nombre_personnes').value);

        if (!nombrePersonnes || nombrePersonnes < minPersonne) {
            alert(`Ce menu nécessite au minimum ${minPersonne} personnes.`);
            return;
        }

        try {
            const reponse = await fetch('/add_menu', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ menuId: menuId, action: 'add', nombrePersonnes: nombrePersonnes })
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

    async function calculerFraisLivraison(adresse) {

        const geoReponse = await fetch(
            `https://api.openrouteservice.org/geocode/search?api_key=${ORS_KEY}&text=${encodeURIComponent(adresse)}&size=1`
        );

        const geoData = await geoReponse.json();

        if (!geoData.features || geoData.features.length === 0) {
            fraisLivraisonEl.textContent = 'Adresse introuvable';
            return;
        }

        const coordonnees = geoData.features[0].geometry.coordinates;
        const longitude   = coordonnees[0];
        const latitude    = coordonnees[1];

        const ville = geoData.features[0].properties.locality ?? '';

        if (ville.toLowerCase() === 'bordeaux') {
            fraisLivraisonEl.textContent = 'Livraison gratuite (Bordeaux)';
            document.getElementById('commande_frais_livraison').value = 0;
            return;
        }

        const distReponse = await fetch('https://api.openrouteservice.org/v2/matrix/driving-car', {
            method: 'POST',
            headers: {
                'Authorization': ORS_KEY,
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                locations: [
                    [BORDEAUX_COORDS[1], BORDEAUX_COORDS[0]],
                    [longitude, latitude]
                ],
                metrics: ['distance']
            })
        });

        const distData = await distReponse.json();

        const distanceMetres = distData.distances[0][1];
        const distanceKm     = distanceMetres / 1000;

        const frais = 5 + (distanceKm * 0.59);

        fraisLivraisonEl.textContent = 'Frais de livraison : ' + frais.toFixed(2) + '€ (' + distanceKm.toFixed(1) + ' km)';
        document.getElementById('commande_frais_livraison').value = frais.toFixed(2);
    }

    adresseInput.addEventListener('blur', async () => {
        if (adresseInput.value.trim() !== '') {
            try {
                await calculerFraisLivraison(adresseInput.value);
            } catch (erreur) {
                fraisLivraisonEl.textContent = "Impossible de calculer les frais de livraison.";
                console.error("Erreur calcul livraison :", erreur);
            }
        }
    });

});
