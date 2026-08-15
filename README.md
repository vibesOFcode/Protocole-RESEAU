# Projet SANET - Comparaison des Protocoles TCP Reno et TCP Vegas

##  Description du Projet

Ce projet est une simulation réseau implémentée avec **NS2 (Network Simulator 2)** pour évaluer et comparer les performances des protocoles TCP Reno (TCP Newreno) et TCP Vegas dans un environnement réseau SANET.

L'objectif est d'analyser les différences de comportement entre ces deux protocoles en termes de :

- **Débit de transmission**
- **Taux de perte de paquets**
- **Gestion de la congestion**
- **Stabilité sous conditions variables**

---

##  Architecture Réseau

La topologie réseau utilisée dans les simulations comprend :

- **2 sources** (src1, src2) : Points d'émission des données
- **3 passerelles** (gw1, gw2, gw3) : Routeurs intermédiaires
- **2 destinations** (dst1, dst2) : Points de réception des données

**Configuration des liens réseau :**

- Bande passante : 1 Mb/s
- Délai de propagation : 10 ms
- Discipline de file d'attente : DropTail

---

##  Structure des Fichiers

### Scénarios de Simulation

#### **SCENARIO1.tcl** - TCP Newreno vs TCP Vegas

- Flux 1 : **TCP Newreno** (src1 → dst1)
- Flux 2 : **TCP Vegas** (src2 → dst2)
- Objectif : Comparer directement les deux protocoles dans des conditions identiques

#### **SCENARIO2.tcl** - TCP Newreno vs TCP Newreno

- Flux 1 : **TCP Newreno** (src1 → dst1)
- Flux 2 : **TCP Newreno** (src2 → dst2)
- Objectif : Établir une baseline avec deux flux identiques

#### **SCENARIO3.tcl** - TCP Vegas vs TCP Vegas

- Flux 1 : **TCP Vegas** (src1 → dst1)
- Flux 2 : **TCP Vegas** (src2 → dst2)
- Objectif : Observer le comportement de TCP Vegas en concurrence avec lui-même

---

##  Résultats et Analyse

Les fichiers de traces générés par NS2 ont été exploités afin d’extraire les métriques de
performance. Les résultats ont été visualisés à l’aide de graphiques pour comparer l’effica-
cité des protocoles TCP Reno et TCP Vegas dans l’environnement SANET. Observations
principales : TCP Reno présente un débit plus élevé mais engendre un taux de perte de
paquets plus important. TCP Vegas offre un meilleur contrôle de congestion, réduisant
ainsi les pertes et le délai de transmission. TCP Vegas maintient une performance plus
stable, même sous des conditions de réseau variables.
L’analyse de la courbe met en évidence une différence significative entre TCP New
Reno et TCP Vegas en termes de gestion de la congestion. Globalement, TCP New Reno
(courbe bleue) affiche un taux de perte de paquets plus élevé et plus fluctuant, tandis
que TCP Vegas (courbe orange) maintient un taux de perte faible et stable tout au long
de la simulation. Dans la phase initiale (0 - 500 unités de temps), les deux protocoles
commencent avec un faible taux de perte, mais TCP New Reno connaît une montée
rapide, atteignant un pic autour de 600 unités de temps, alors que TCP Vegas conserve
une performance plus stable. Pendant la phase intermédiaire (500 - 2000 unités de temps),
le taux de perte de TCP New Reno diminue légèrement après son pic initial, mais reste
supérieur à celui de TCP Vegas, qui continue à maintenir un taux très bas et constant.
Enfin, dans la phase finale (2000 - 3000 unités de temps), TCP New Reno présente une
tendance à la hausse du taux de perte, révélant une gestion de la congestion moins efficace,
tandis que TCP Vegas maintient un taux de perte faible, confirmant ainsi sa meilleure
capacité à anticiper et à limiter la congestion.