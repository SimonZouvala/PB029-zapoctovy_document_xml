<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : to-html.xsl
    Created on : 28. prosince 2020, 15:23
    Author     : simon
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns="http://www.w3.org/1999/xhtml">
    
    <xsl:output method="xml"
                doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
                encoding="UTF-8"
                indent="yes"
    />

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/adresar">
        <html>
            <head>
                <title>Databáze dontaktů</title>
                <meta http-equiv="Content-Language" content="cs"/>
                <meta http-equiv="Cache-Control" content="no-cache"/>
                <meta name="description" content="Databáze všech kontkatů včetně adres a poznámek."/>
                <meta name="keywords" content="kontakt, adresa, poznámka"/>
                <link rel="stylesheet" href="kontakt-style.css" type="text/css" media="screen" />
            </head>
            <body>
                <h1>Kontakty</h1>
                 
            <xsl:for-each select="osoba">
            <xsl:sort select="@prijmeni"/>
            <div class="person">
            <h2>
            <xsl:value-of select="@jmeno"/> <xsl:text> </xsl:text> <xsl:value-of select="@prijmeni"/>   
            </h2>
            <xsl:apply-templates select="kontakty"/>
            <xsl:apply-templates select="adresy"/>
            <xsl:apply-templates select="poznamky"/>
             <br/>
            </div>
           
            </xsl:for-each>
            
        
            </body>
        </html>
    </xsl:template>
    
<!--    <xsl:template match="osoba">
        <div>
            <xsl:text>Tady jsem byl poprvé</xsl:text>
        </div>
        <div>
            <xsl:for-each select=".">
            <xsl:sort select="@prijmeni"/>
            <h2>
            <xsl:value-of select="@jmeno"/> <xsl:text> </xsl:text> <xsl:value-of select="@prijmeni"/>   
            </h2>
            <xsl:apply-templates select="kontakty"/>
            <xsl:apply-templates select="adresy"/>
            <xsl:apply-templates select="poznamky"/>
            </xsl:for-each>
            
        </div>
    </xsl:template>-->
    
    <xsl:template match="kontakty">
        <xsl:for-each select="kontakt">
        <div class="item">
            <xsl:choose>
            
            <xsl:when test="@typ">
                <div class="itemName">Kontakt <i>(<xsl:value-of select="@typ"/>)</i></div>
            </xsl:when>
            <xsl:otherwise>
                <div class="itemName">Kontakt</div>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:apply-templates select="mail"/>
        <xsl:apply-templates select="telefon"/>
        <xsl:apply-templates select="web"/>
        <xsl:apply-templates select="dalsi"/>
        </div>
        </xsl:for-each>
    </xsl:template>
    
<!--    <xsl:template match="kontakt">
        
    </xsl:template>-->
    
     <xsl:template match="mail">
        <span class="label">Email:</span>
        <xsl:text> </xsl:text>
        <a class="value">
            <xsl:attribute name="href">mailto:<xsl:value-of select="text()"/></xsl:attribute>
            <xsl:value-of select="text()"/>
        </a>
        <br/>
    </xsl:template>
    
    <xsl:template match="telefon">
        <span class="label">Telefon: </span>
        <xsl:text> </xsl:text>
        <xsl:value-of select="text()"/>
        <br/>
    </xsl:template>
    
     <xsl:template match="web">
        <span class="label">web: </span>
        <xsl:text> </xsl:text>
        <a class="value">
            <xsl:attribute name="href">https://<xsl:value-of select="text()"/></xsl:attribute>
            <xsl:value-of select="text()"/>
        </a>
        <br/>
    </xsl:template>
    
    <xsl:template match="dalsi">
        <span class="label"><xsl:value-of select="@nazev"/>:</span>
        <xsl:text> </xsl:text>
        <xsl:value-of select="text()"/>
        <br/>
    </xsl:template>
    
    
    
    
    
    <xsl:template match="adresy">
        
        <xsl:for-each select="adresa">
            <div class="item">
                <div class="itemName">Adresa</div>
                <xsl:apply-templates select="ulice"/>
                <xsl:apply-templates select="cp"/>
                <xsl:apply-templates select="mesto"/>
                <xsl:apply-templates select="psc"/>
            </div>
        </xsl:for-each>
        <!--<span class="adresa"><xsl:value-of select="adresa/ulice/text()"/>  <xsl:value-of select="adresa/cp/text()"/>  <xsl:value-of select="adresa/mesto/text()"/>  <xsl:value-of select="adresa/psc/text()"/></span>-->
    </xsl:template>
    
     <xsl:template match="ulice">
        <span class="label">Ulice:</span>
        <xsl:text> </xsl:text>
        <xsl:value-of select="text()"/>
    </xsl:template>
    
    <xsl:template match="cp">
        <xsl:text> </xsl:text>
        <xsl:value-of select="text()"/>
        <br/>
    </xsl:template>
    
    <xsl:template match="mesto">
        <span class="label">Město:</span>
        <xsl:text> </xsl:text>
        <xsl:value-of select="text()"/>

    </xsl:template>
    
    <xsl:template match="psc">
        <xsl:text> </xsl:text>
        <xsl:value-of select="text()"/>
        <br/>
    </xsl:template>
    
    <xsl:template match="poznamky">
        <div class="item">
            <div class="itemName">Poznámka:</div>
            
                <xsl:for-each select="poznamka">
                        <xsl:value-of select="text()"/>
                    <br/>
                </xsl:for-each>
        </div>
    </xsl:template>

</xsl:stylesheet>
