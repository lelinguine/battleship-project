<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>battleship-project</title>
                <link rel="icon" href="./assets/icon.svg" type="image/svg"/>
                <link href="./assets/base.css" rel="stylesheet"/>
                <link href="./assets/main.css" rel="stylesheet"/>
            </head>
            <body>
                <div class="rule-container">
                    <div class="title"><h1>Battleship</h1><p><mark class="alternative">1.0-a</mark></p></div>
                    <p class="rules">How to play? <mark class="default">Each player strategically places their fleet of ships on a hidden grid while aiming to sink their opponent’s ships by guessing positions and flipping adjacent cells to gain control. The player with the most captured spaces and sunk ships at the end wins.</mark></p>

                    <div class="view">
                        <div id="board-container">
                            <svg xmlns="http://www.w3.org/2000/svg" width="770" height="770" viewBox="0 0 770 770">

                                <image href="./assets/grid.svg" x="0" y="0" width="770" height="770"/>

                                <!-- Etat des cases -->
                                <xsl:for-each select="grille/case">
                                    <xsl:variable name="ligne" select="@ligne"/>
                                    <xsl:variable name="colonne" select="@colonne"/>
                                    
                                    <!-- Convertir la ligne de A-J en 1-10 -->
                                    <xsl:variable name="ligneInt">
                                        <xsl:choose>
                                            <xsl:when test="$ligne = 'A'">1</xsl:when>
                                            <xsl:when test="$ligne = 'B'">2</xsl:when>
                                            <xsl:when test="$ligne = 'C'">3</xsl:when>
                                            <xsl:when test="$ligne = 'D'">4</xsl:when>
                                            <xsl:when test="$ligne = 'E'">5</xsl:when>
                                            <xsl:when test="$ligne = 'F'">6</xsl:when>
                                            <xsl:when test="$ligne = 'G'">7</xsl:when>
                                            <xsl:when test="$ligne = 'H'">8</xsl:when>
                                            <xsl:when test="$ligne = 'I'">9</xsl:when>
                                            <xsl:when test="$ligne = 'J'">10</xsl:when>
                                        </xsl:choose>
                                    </xsl:variable>

                                    <!-- Calculer les coordonnées -->
                                    <xsl:variable name="x" select="($colonne) * 70"/>
                                    <xsl:variable name="y" select="($ligneInt) * 70"/>

                                    <!-- Vérifier si la case touche un bateau -->
                                    <xsl:variable name="caseToucheBateau" select="//bateau/case[@ligne = $ligne and @colonne = $colonne]"/>

                                    <!-- Affichage des symboles pour "touché" ou "eau" -->
                                    <g font-family="Arial" font-weight="bold" font-size="20" fill="black" text-anchor="middle" dominant-baseline="middle">
                                        <xsl:choose>
                                            <!-- Si la case touche un bateau (on vérifie si la variable contient des éléments) -->
                                            <xsl:when test="count($caseToucheBateau) > 0">
                                                <text x="{$x + 35}" y="{$y + 35}">X</text> <!-- Affiche un "X" pour un bateau touché -->
                                            </xsl:when>
                                            <!-- Si la case n'a pas de bateau (eau) -->
                                            <xsl:otherwise>
                                                <text x="{$x + 35}" y="{$y + 35}">O</text> <!-- Affiche un "O" pour une case d'eau -->
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </g>

                                </xsl:for-each>


                                <!-- Affichage des bateaux -->
                                <!-- <xsl:for-each select="grille/bateau/case">
                                    <xsl:variable name="ligne" select="@ligne"/>
                                    <xsl:variable name="colonne" select="@colonne"/>
                                    <xsl:variable name="ligneInt">
                                        <xsl:choose>
                                            <xsl:when test="$ligne = 'A'">1</xsl:when>
                                            <xsl:when test="$ligne = 'B'">2</xsl:when>
                                            <xsl:when test="$ligne = 'C'">3</xsl:when>
                                            <xsl:when test="$ligne = 'D'">4</xsl:when>
                                            <xsl:when test="$ligne = 'E'">5</xsl:when>
                                            <xsl:when test="$ligne = 'F'">6</xsl:when>
                                            <xsl:when test="$ligne = 'G'">7</xsl:when>
                                            <xsl:when test="$ligne = 'H'">8</xsl:when>
                                            <xsl:when test="$ligne = 'I'">9</xsl:when>
                                            <xsl:when test="$ligne = 'J'">10</xsl:when>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <xsl:variable name="x" select="($colonne) * 70"/>
                                    <xsl:variable name="y" select="($ligneInt) * 70"/>
                                    <g font-family="Arial" font-weight="bold" font-size="20" fill="black" text-anchor="middle" dominant-baseline="middle">
                                        <text x="{$x + 35}" y="{$y + 35}">1</text>
                                    </g>
                                </xsl:for-each> -->
                            </svg>

                            <xsl:variable name="grille-valide">
                                <!-- Vérification de la validité de la grille -->
                                <xsl:choose>
                                    <!-- Vérification s'il y a bien tous les bateaux de la flotte -->
                                    <xsl:when test="not(grille/bateau[@type = 'porte-avions']) or grille/bateau[@type = 'porte-avions'][count(case) != 5]">
                                        <xsl:value-of select="' Erreur [Porte-avions]'" />
                                    </xsl:when>
                                    <xsl:when test="count(grille/bateau[@type = 'croiseur']) != 2 or grille/bateau[@type = 'croiseur'][count(case) != 4]">
                                        <xsl:value-of select="'Erreur [Croiseur]'" />
                                    </xsl:when>
                                    <xsl:when test="count(grille/bateau[@type = 'contre-torpilleur']) != 3 or grille/bateau[@type = 'contre-torpilleur'][count(case) != 3]">
                                        <xsl:value-of select="'Erreur [Contre-torpilleur].'" />
                                    </xsl:when>
                                    <xsl:when test="count(grille/bateau[@type = 'sous-marin']) != 4 or grille/bateau[@type = 'sous-marin'][count(case) != 2]">
                                        <xsl:value-of select="'Erreur [Sous-marin]'" />
                                    </xsl:when>
                                    <!-- Vérification de la présence d'un bateau de 1 case -->
                                    <xsl:when test="grille/bateau[count(case) &lt; 1 or count(case) &gt; 5]">
                                        <xsl:value-of select="'Erreur [Inconnu]'" />
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:variable>

                            <xsl:variable name="affichage-grille">
                                <!-- Si la grille est invalide, afficher le message, sinon masquer -->
                                <xsl:choose>
                                    <xsl:when test="not(grille/bateau[@type = 'porte-avions']) or grille/bateau[@type = 'porte-avions'][count(case) != 5]
                                    or count(grille/bateau[@type = 'croiseur']) != 2 or grille/bateau[@type = 'croiseur'][count(case) != 4]
                                    or count(grille/bateau[@type = 'contre-torpilleur']) != 3 or grille/bateau[@type = 'contre-torpilleur'][count(case) != 3]
                                    or count(grille/bateau[@type = 'sous-marin']) != 4 or grille/bateau[@type = 'sous-marin'][count(case) != 2]
                                    or grille/bateau[count(case) &lt; 1 or count(case) &gt; 5]">
                                        <xsl:value-of select="'display: flex;'" />
                                    </xsl:when>
                                </xsl:choose>
                            </xsl:variable>

                            <!-- Message d'erreur ou validation -->
                            <div id="context" style="{ $affichage-grille }">
                                <p><xsl:value-of select="$grille-valide"/></p>
                            </div>

                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>