<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
	

	<!-- request parameters -->
	
	<!-- parallel unit id -->
	<xsl:param name="id"/>
		
		
		
	<xsl:template match="/">
		<html>
			<head>
				<title>SYNOPTIC BROWSER: <xsl:value-of select="/synopsis/title"/></title>
				
					<script src="synopsis.js"> &#160; </script>
				
					<style type="text/css">

					body { font-family: Arial; font-size: 12pt; background-color: #f0f0f0; margin: 0px; margin-left: 4px; margin-right: 5px; }
					
					.components { border: 1px solid black; padding: 2px; background-color: #f0fff0; }

					.components th { text-align: left; }
					
					.title { text-align: center; font-size: 14pt; font-weight: bold; margin-bottom: 12pt; }
					
					.views { height: 300px; overflow: auto; position: relative; margin-top: 12px;
						border: 2px dotted #ff0000;
					 }
					 
					 .view { margin-bottom: 6px; font-size: 12pt; padding: 4pt;}
					
					.compVal { padding-left: 12pt; padding-right: 12pt; }
					
					</style>
				
			</head>
			<body>
				<xsl:apply-templates/>	
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="parallelUnit/title">
		<div class="title"><xsl:apply-templates/>
<span style="width:50px;"/>
				<span><a href="menu">MENU</a></span>		
		</div>
	</xsl:template>
	
	<xsl:template match="synopticUnits"/>
	
	<!-- 
	    create table to show data on components in parallel unit
	-->
	<xsl:template match="parallelUnit/components">
		<div class="components">
			<table width="80%">
				<thead>
					<tr>
						<th>id</th>
						<th>text</th>
						<th>book</th>
						<th>description</th>
						<th>range type</th>
						<th>start</th>
						<th>end</th>
					</tr>
				</thead>
				<tbody>
					<xsl:apply-templates/>	
				</tbody>
			</table>
		</div>
	</xsl:template>
		
	<!--
		match each component in components element
	    and format information as a table row
    -->	
	<xsl:template match="component">
		<tr>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="position() mod 2 = 0">even-row</xsl:when>
					<xsl:otherwise>odd-row</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		 
			<td><xsl:value-of select="@id"/></td>
			<td><xsl:value-of select="text"/></td>
			<td><xsl:value-of select="range/@book"/></td>
			<td><xsl:value-of select="label"/></td>
			<td><xsl:value-of select="range/@type"/></td>
			<td><xsl:value-of select="range/@start"/></td>
			<td><xsl:value-of select="range/@end"/></td>
			
		</tr>
	</xsl:template>	
	
	<xsl:template match="views">
		<div class="views">
			<xsl:apply-templates select="view">
				<xsl:sort select="@displayMode" order="descending"/>		
			</xsl:apply-templates>	
		</div>
	</xsl:template>
	
	<xsl:template match="view">
		<div class="view">
			<div>view <xsl:value-of select="@id"/> - <a href="view?id={$id}&amp;view={@id}"><xsl:value-of select="label"/></a> (<xsl:value-of select="@displayMode"/>)</div>
		<!--	<div class="viewDescription"><xsl:value-of select="description"/></div> -->
			<xsl:apply-templates select="components">
				
				
			</xsl:apply-templates>		
		</div>
	</xsl:template>
	
	<xsl:template match="components">
		<div class="viewComponents">
			<xsl:for-each select="col">
				<span class="compVal"><xsl:value-of select="@ref"/></span>
			</xsl:for-each>	
		</div>
	</xsl:template>
	
	
</xsl:stylesheet>
