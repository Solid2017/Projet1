À chaque nouvelle version de TchadPay, Rokia rejoue à la main 120 cas de test de régression. Cela lui prend trois jours. L'équipe voudrait livrer toutes les deux semaines : ce n'est plus tenable. La solution est d'**automatiser** une partie des tests : un programme exécute les vérifications à la place d'une personne, en quelques minutes, autant de fois qu'on le souhaite.

> **Objectifs de ce chapitre**
> - Savoir quels tests automatiser en priorité
> - Écrire un test unitaire avec PHPUnit
> - Comprendre la structure Préparer / Agir / Vérifier
> - Découvrir l'automatisation des tests d'interface
> - Intégrer les tests automatisés dans un pipeline

## Que faut-il automatiser ?

Tout automatiser n'est ni possible ni souhaitable. On automatise en priorité :

- les tests **répétés souvent** (régression) ;
- les **calculs et règles métier** critiques (frais, limites, soldes) ;
- les **parcours essentiels** (connexion, paiement) ;
- les tests avec **beaucoup de combinaisons de données**.

On garde en manuel :

- les tests **exploratoires**, où le testeur cherche librement des problèmes avec son expérience et sa créativité ;
- les tests d'**utilisabilité** et de ressenti ;
- les fonctionnalités qui changent encore beaucoup.

> **Info** : un test automatisé a un coût : il faut l'écrire, puis le maintenir quand l'application évolue. Il devient rentable quand il est exécuté de nombreuses fois.

## Un premier test unitaire

Prenons la règle de calcul des frais de TchadPay : 1 % du montant, avec un minimum de 100 FCFA. Le code PHP :

```php
<?php
// src/Frais.php
class Frais
{
    public static function calculer(int $montant): int
    {
        if ($montant <= 0) {
            throw new InvalidArgumentException('Montant invalide');
        }
        return max(100, (int) round($montant * 0.01));
    }
}
```

Le test avec **PHPUnit**, l'outil de référence en PHP :

```php
<?php
// tests/FraisTest.php
use PHPUnit\Framework\TestCase;

class FraisTest extends TestCase
{
    public function testUnPourcentPourUnMontantNormal(): void
    {
        // Préparer
        $montant = 50000;
        // Agir
        $frais = Frais::calculer($montant);
        // Vérifier
        $this->assertSame(500, $frais);
    }

    public function testMinimumDeCentFrancs(): void
    {
        $this->assertSame(100, Frais::calculer(3000));
    }

    public function testMontantNegatifRefuse(): void
    {
        $this->expectException(InvalidArgumentException::class);
        Frais::calculer(-500);
    }
}
```

On lance les tests avec `vendor/bin/phpunit tests` : PHPUnit affiche un point par test réussi et le détail de chaque échec.

## La structure Préparer / Agir / Vérifier

Un bon test automatisé suit trois étapes, en anglais *Arrange / Act / Assert* :

1. **Préparer** les données et l'état de départ.
2. **Agir** : appeler la fonction ou l'action à tester.
3. **Vérifier** que le résultat est celui attendu, avec une **assertion**.

Règles d'or :

- **un comportement par test**, avec un nom qui le décrit (`testMinimumDeCentFrancs`) ;
- des tests **indépendants** les uns des autres, qui peuvent s'exécuter dans n'importe quel ordre ;
- des tests **rapides** et **déterministes** : le même résultat à chaque exécution.

> **Astuce** : quand un bug est trouvé, commence par écrire un test automatisé qui le reproduit (il échoue), puis corrige le code (le test passe). Ce bug ne pourra plus jamais revenir sans que l'équipe le sache.

## Les tests d'interface

Pour automatiser un parcours complet dans le navigateur (se connecter, choisir une facture, payer), on utilise un outil qui pilote un vrai navigateur, comme **Playwright** ou **Cypress**. Exemple avec Playwright en JavaScript :

```js
import { test, expect } from '@playwright/test';

test('un client paie sa facture d\'électricité', async ({ page }) => {
  await page.goto('https://test.tchadpay.td/connexion');
  await page.fill('#telephone', '66000001');
  await page.fill('#code', '0000');
  await page.click('text=Se connecter');
  await page.click('text=Électricité');
  await page.fill('#reference', 'F-2026-1042');
  await page.click('text=Payer');
  await expect(page.locator('.message-succes')).toContainText('Paiement réussi');
});
```

Pour les applications mobiles, **Appium** joue le même rôle sur Android et iOS.

> **Attention** : les tests d'interface sont lents et peuvent devenir **instables** (*flaky*) : ils échouent parfois sans vraie raison, à cause d'un chargement un peu plus lent. Un test instable perd vite la confiance de l'équipe. Garde-les peu nombreux, réservés aux parcours critiques, et corrige vite ceux qui deviennent instables.

## Les tests dans le pipeline

Les tests automatisés prennent toute leur valeur quand ils s'exécutent **automatiquement à chaque modification du code**, dans le pipeline d'intégration continue (CI). Si un test échoue, la modification n'est pas fusionnée : la régression est détectée en quelques minutes, au lieu de l'être par un client des semaines plus tard.

## À toi de jouer

1. Installe PHP et Composer, crée un dossier de projet et installe PHPUnit avec `composer require --dev phpunit/phpunit`.
2. Crée la classe `Frais` ci-dessus et ses trois tests ; exécute-les.
3. Ajoute un test pour la règle « frais plafonnés à 2 000 FCFA » ; il doit échouer.
4. Modifie la classe `Frais` pour que ce nouveau test passe, sans casser les autres.
5. Écris les tests des valeurs limites : 1, 9 999, 10 000, 10 001 et 1 000 000 FCFA.

> **Indice pour l'étape 4** : `min(2000, max(100, (int) round($montant * 0.01)))`. Vérifie que le test des 50 000 FCFA (500 de frais) passe toujours.

## Vérifie tes acquis

1. Pourquoi ne pas automatiser les tests exploratoires ?
2. Quelles sont les trois étapes d'un test automatisé ?
3. Qu'est-ce qu'un test instable et pourquoi est-il dangereux ?

> **Réponses** : 1. Parce qu'ils reposent sur l'intuition et la créativité du testeur, qu'un script ne peut pas reproduire. 2. Préparer, agir, vérifier. 3. Un test qui échoue parfois sans vraie raison ; l'équipe finit par ignorer ses échecs, y compris les vrais.

## En résumé

- On automatise les tests **répétitifs**, les **règles métier** et les **parcours critiques** ; l'exploratoire reste manuel.
- **PHPUnit** (PHP), et des équivalents dans chaque langage, permettent d'écrire des tests unitaires.
- Un test suit **Préparer / Agir / Vérifier**, teste un seul comportement et reste indépendant.
- **Playwright**, **Cypress** et **Appium** automatisent les tests d'interface, à utiliser avec modération.
- Les tests prennent toute leur valeur exécutés à chaque modification, dans la **CI**.

## Pour aller plus loin

- [La documentation de PHPUnit](https://docs.phpunit.de/)
- Demande au mentor IA : « Écris avec moi les tests PHPUnit d'une fonction qui vérifie un numéro de téléphone tchadien. »
