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

                                <!-- Cases de la grille -->
                                <xsl:for-each select="grille/case">
                                    <xsl:variable name="ligne" select="@ligne"/>
                                    <xsl:variable name="colonne" select="@colonne"/>
                                    <xsl:variable name="etat" select="@etat"/>

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

                                    <!-- Calculer les coordonnées, en tenant compte des indices (1-10 et A-J) -->
                                    <xsl:variable name="x" select="($colonne) * 70"/>
                                    <xsl:variable name="y" select="($ligneInt) * 70"/>
                                    
                                    <!-- Affichage des symboles pour "touché", "eau" et autres -->
                                    <g font-family="Arial" font-weight="bold" font-size="20" fill="black" text-anchor="middle" dominant-baseline="middle">
                                        <xsl:choose>
                                            <!-- Si l'état est "touché", afficher un "X" -->
                                            <xsl:when test="$etat = 'touché'">
                                                <text x="{$x + 35}" y="{$y + 35}">X</text>
                                            </xsl:when>
                                            <!-- Si l'état est "eau", afficher un "O" -->
                                            <xsl:when test="$etat = 'eau'">
                                                <text x="{$x + 35}" y="{$y + 35}">O</text>
                                            </xsl:when>
                                        </xsl:choose>
                                    </g>
                                </xsl:for-each>

                            </svg>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>