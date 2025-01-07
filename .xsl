<?xml version="1.0" encoding="UTF-8"?>

<!-- Feuille de style XSLT -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" indent="yes"/>

    <!-- Transformation principale -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Grille de Bataille Navale</title>







                
            </head>
            <body>
                <h1>Grille de Bataille Navale</h1>
                <svg width="400" height="400" xmlns="http://www.w3.org/2000/svg">
                    <!-- Dessiner la grille -->
                    <xsl:for-each select="grille/case">
                        <rect x="{(string-length(@colonne) - 64) * 40}" y="{(@ligne - 1) * 40}" width="40" height="40" fill="blue" stroke="black" stroke-width="1"/>
                    </xsl:for-each>

                    <!-- Dessiner les bateaux -->
                    <xsl:for-each select="grille/bateau">
                        <xsl:for-each select="case">
                            <rect x="{(string-length(@colonne) - 64) * 40}" y="{(@ligne - 1) * 40}" width="40" height="40" fill="gray" stroke="black" stroke-width="1"/>
                        </xsl:for-each>
                    </xsl:for-each>

                    <!-- Marquer les cases touchées -->
                    <xsl:for-each select="grille/case[@etat='touché']">
                        <circle cx="{(string-length(@colonne) - 64) * 40 + 20}" cy="{(@ligne - 1) * 40 + 20}" r="10" fill="red"/>
                    </xsl:for-each>

                    <!-- Marquer les cases touchées-coulées -->
                    <xsl:for-each select="grille/case[@etat='touché-coulé']">
                        <circle cx="{(string-length(@colonne) - 64) * 40 + 20}" cy="{(@ligne - 1) * 40 + 20}" r="10" fill="black"/>
                    </xsl:for-each>
                </svg>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>