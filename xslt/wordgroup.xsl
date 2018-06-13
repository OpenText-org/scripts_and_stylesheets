<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:wg="http://www.opentext.org/ns/word-group"
                xmlns:xlink="http://www.w3.org/1999/xlink"		
	 xmlns:cl="http://www.opentext.org/ns/clause"
          	version="1.0">


<xsl:param name="showIDs">1</xsl:param>

  <xsl:param name="modifier-names">
    <modifiers>
      <modifier name="specifier" abbrev="sp"/>
      <modifier name="definer" abbrev="df"/>
      <modifier name="qualifier" abbrev="ql"/>
      <modifier name="relator" abbrev="rl"/>
      <modifier name="connector" abbrev="cn"/>
    </modifiers>
  </xsl:param>

  <xsl:output method="xml" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Word group annotation</title>
	<style>
	.grk { font-family: Palatino Linotype, Athena, 'Georgia Greek'}
	.wid { font-family: Arial; font-size: 8pt; color: green}
	td {  background-color: #ffffff; padding: 2px}
        .modHead { font-family: Arial; background-color: #c0c0c0; 
                   color: blue; font-size: 8pt; text-align: center}
	.group { background-color: #000000; margin-bottom: 20px;}
	.word { border: 1px #303030 solid}
        .group-label { font-family: Arial; font-size: 9pt;
                       text-align: left;
                       color: red; vertical-align: center;
                     }

	</style>

      </head>
      <body>
      <!--
        <hr/><a href="http://www.opentext.org"><img src="http://www.opentext.org/images/small-logo.jpeg" border="0"/></a><h2>Rom 1 (Word group level annotation for WH text)</h2>
      <h3>Version 0.1 (25/01/02)</h3>
      <p>Comments and corrections to <a href="mailto:m.odonnell@roehampton.ac.uk">m.odonnell@roehampton.ac.uk</a></p>
-->
<p><u>Relationships</u> 
<!-- (see <a href="http://www.opentext.org/specifications/wordgroup/wordgroup01.html">http://www.opentext.org/specifications/wordgroup/wordgroup01.html</a> for more details) -->
<ul>
<li>sp - specifier</li>
<li>df - definer</li>
<li>ql - qualifier</li>
<li>rl - relator</li>
<li>cn - connector</li>
</ul>
</p>
<br/>(N.B. This page uses Unicode encoding, suitable fonts include Georgia Greek, Athena)
      
<hr/><br/>



        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="wg:group">
    <table class="group">
      <xsl:apply-templates/>
    </table>
  </xsl:template>

  <xsl:template match="wg:head">
    <tbody>
      <tr>
        <td class="group-label"><xsl:value-of select="concat('wg', substring-after(parent::wg:group/@id,'_'))"/></td>
        <td><xsl:apply-templates/></td>
      </tr>
    </tbody>
  </xsl:template>

  <xsl:template match="wg:word">
    <xsl:variable name="id" select="@id"/>
    <xsl:choose>
    <xsl:when test="wg:modifiers">
      <table class="word">
        <tbody>
          <tr>
            <td>
              <xsl:attribute name="colspan">
                <xsl:value-of select="count(wg:modifiers/*)"/>
              </xsl:attribute>
              <xsl:if test="$showIDs=1">
              <span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span></xsl:if>
              <span class="grk"><xsl:value-of select="@wf"/></span>
            </td>
          </tr>
          <tr>
            <xsl:call-template name="modifier-heading">
              <xsl:with-param name="modifiers" select="wg:modifiers"/>
            </xsl:call-template>
          </tr>
          <tr>
            <xsl:apply-templates/>
          </tr>
        </tbody>
      </table>
    </xsl:when>      
    <xsl:otherwise>
      <span class="word">
      <xsl:if test="$showIDs=1">
      <span class="wid"><xsl:value-of select="substring-after(@id,'.')"/></span>
      </xsl:if>
      <span class="grk"><xsl:value-of select="@wf"/></span>
</span>
    </xsl:otherwise>
    </xsl:choose>

  </xsl:template>


  <xsl:template match="wg:specifier|wg:definer|wg:qualifier|wg:relator|wg:connector">
    <td>
      <xsl:apply-templates/>
    </td>
  </xsl:template>

  <xsl:template name="modifier-heading">
    <xsl:param name="modifiers"/>
    
     
    <xsl:for-each select="$modifiers/*">
      <xsl:variable name="local" select="local-name()"/>
      
   		 <td class="modHead">
   		 	<xsl:choose>
   		 		<xsl:when test="$local = 'specifier'">sp</xsl:when>
     		 		<xsl:when test="$local = 'qualifier'">ql</xsl:when>
       		 	<xsl:when test="$local = 'relator'">rl</xsl:when>
            		 	<xsl:when test="$local = 'definer'">df</xsl:when>
                 		<xsl:when test="$local = 'connector'">cn</xsl:when>
   		 	</xsl:choose>
   		 </td>  
    </xsl:for-each>
    
    <!-- <xsl:value-of select="$modifier-names//modifier[@name=$local]/@abbrev"/> -->
    
  </xsl:template>

</xsl:stylesheet>
