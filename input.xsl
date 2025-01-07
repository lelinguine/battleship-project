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



















                        <img src="./assets/grid.svg"/>

                    
                    
                    
                    
                    
                    
                    </div>

                    
                    <div id="context"><p>Bad board configuration!</p></div>
                    <div id="context"><p>Player wins!</p></div>
                    <div id="context"><p>Player loose!</p></div>
                </div>







            </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>