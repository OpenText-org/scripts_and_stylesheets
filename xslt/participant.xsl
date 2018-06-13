<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                
xmlns:wg="http://www.opentext.org/ns/word-group" xmlns:cl="http://www.opentext.org/ns/clause"
 xmlns:pl="http://www.opentext.org/ns/paragraph" xmlns:xlink="http://www.w3.org/1999/xlink" 

>
  

  <xsl:output method="xml" indent="yes"/>

  <xsl:param name="ch"/>
  <xsl:param name="bookname"/>
  <xsl:param name="reload"/>



  <xsl:template match="/">
  <html xmlns="http://www.w3.org/1999/xhtml">

    <head>
      <title>Participant annotation - Chapter <xsl:value-of select="$ch"/></title>
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
      <meta content="-1" http-equiv="Expires"/>	
      <meta content="no-cache" http-equiv="Pragma"	/>
      <link href="participant.css" type="text/css" rel="stylesheet"/>
	<script src="participant.js" type="text/javascript">
		<xsl:text>   </xsl:text>
	</script>
    </head>

    <body>


      <div id="words">
        <xsl:apply-templates select="//chapter[cl:clause]"/>

    <form name="xml" id="xml" method="post">
		 <xsl:attribute name="action">
			 <xsl:choose>
					<xsl:when test="contains($reload,'synopsis')">/opentext/synopsis/updateParticipants</xsl:when>
					<xsl:otherwise>updateParticipants</xsl:otherwise>
				</xsl:choose>
		 </xsl:attribute>
         <input type="hidden" name="book"><xsl:attribute name="value"><xsl:value-of select="//chapter/@book"/></xsl:attribute></input>
      <input type="hidden" name="ch" value="{$ch}"/>	
      
      <xsl:if test="string-length($reload)&gt;0">
      <input name="reload" type="hidden" value="{$reload}"/>
      <input name="bookname" type="hidden" value="{$bookname}"/>
      </xsl:if>
     
    </form>

      </div>

		<div id="participants">
		<form action="#">
                  <div>
			<select id="partList" multiple="1" size="20">
				<script>var partNum = <xsl:value-of select="count(//participants//participant) + 1"/></script>
				<xsl:for-each select="//participants//participant">
					<xsl:sort select="@num" data-type="number" case-order="ascending"/>				
					<option value="{@num}"><xsl:value-of select="@num"/>: <xsl:value-of select="@name"/></option>
				</xsl:for-each>
			</select>
			<xsl:if test="//participants//participant &gt; 0">
				<script>
					partName[partNum] = '<xsl:value-of select="@name"/>';
				</script>
			</xsl:if>
                  </div>
                  <div id="partOpts">
					 <div class="plabel">Participant Type:</div>
                    <input type="radio" name="partType" value="gram" onclick="selectPartType(this)" checked="1">Grammaticalized</input>
                    <input type="radio" name="partType" value="redu" onclick="selectPartType(this)">Reduced</input>
                    <input type="radio" name="partType" value="impl" onclick="selectPartType(this)">Implied</input>
                  </div>
                  <div id="refOpts">
                  <div class="plabel">Reference type:</div>
                    <input type="radio" name="refType" value="ana" onclick="selectRefType(this)" checked="1">Anaphoric</input>
                    <input type="radio" name="refType" value="cat" onclick="selectRefType(this)">Cataphoric</input>
                    <input type="radio" name="refType" value="exo" onclick="selectRefType(this)">Exophoric</input>
					<input type="radio" name="refType"  value="0" onclick="selectRefType(this)">n/a</input>
                  </div>              
		  <div>
			<input type="button" onclick="addPart()" value="Add new participant" />
		  </div>
               
                  <div>
					  <input type="button" value="Update" onclick="formData()"	/>
					  <input type="button" onclick="outputWindow(getParticipantData())" value="Output" />
                  </div>

                </form>
		</div>


  </body>
  <head>
	<meta content="-1" http-equiv="Expires"/>	
      <meta content="no-cache" http-equiv="Pragma"	/>
      
	</head>
</html>
</xsl:template>


	<xsl:template match="cl:clause[parent::chapter]">
	
<div class="clauseText">
					<span class="clcomp"><span class="divider">|</span></span>			
					<xsl:apply-templates/>
					<span class="clcomp"><span class="divider">||</span></span>
				
</div>	
			
			
	</xsl:template>
	
	<xsl:template match="cl:clause[ancestor::cl:clause]">
		<span class="compspan">
		<span class="clcomp"><span class="emdivider">[[</span></span>			
		<xsl:apply-templates/>
		<span class="clcomp"><span class="emdivider">]]</span></span>
		</span>
	</xsl:template>
	
	<xsl:template match="cl:S | cl:P | cl:C | cl:A | pl:conj | cl:add">
		<span >
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="cl:clause"></xsl:when>
					<xsl:otherwise>compspan</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="not(preceding-sibling::cl:* or preceding-sibling::pl:*)">clcomp</xsl:when>
					<xsl:otherwise>comp</xsl:otherwise>	
				</xsl:choose>	
			</xsl:attribute>
			<xsl:choose>
				<xsl:when test="not(preceding-sibling::cl:* or preceding-sibling::pl:*) and count(ancestor::cl:clause)&gt;1"></xsl:when>
				<xsl:when test="count(ancestor::cl:clause)&gt;1"><span class="emdivider">|</span></xsl:when>
				<xsl:otherwise><span class="divider">|</span></xsl:otherwise>	
			</xsl:choose>
		
		
		<span>
			<xsl:attribute name="class">
				<xsl:choose>
					<xsl:when test="count(ancestor::cl:clause)&gt;1">emlabel</xsl:when>
					<xsl:otherwise>label</xsl:otherwise>	
				</xsl:choose>
			</xsl:attribute>	
		<xsl:value-of select="local-name()"/></span></span>
		<xsl:apply-templates/>	
		</span>
	</xsl:template>

<xsl:template match="w">
	<xsl:variable name="id" select="@id"/>	
	<xsl:variable name="part" select="//partRefs/chapter[@num=$ch]/wg:part[@xlink:href=$id]/@num"/>
	<xsl:variable name="type" select="//partRefs/chapter[@num=$ch]/wg:part[@xlink:href=$id]/@type"/>		
	<xsl:variable name="rtype" select="//partRefs/chapter[@num=$ch]/wg:part[@xlink:href=$id]/@refType"/>		
	
  <span class="grk" id="{$id}" onclick="select(this)">
	  <xsl:choose>
			<xsl:when test="string-length($part)&gt;0">
				<xsl:attribute name="style">background-color: #c0c0c0</xsl:attribute>
				<xsl:attribute name="partNum"><xsl:value-of select="$part"/></xsl:attribute>	
				<xsl:attribute name="partType"><xsl:value-of select="$type"/></xsl:attribute>
				<xsl:attribute name="refType"><xsl:value-of select="$rtype"/></xsl:attribute>		
				<xsl:value-of select="wf"/>
				<span class="partTag">p<xsl:value-of select="$part"/><xsl:text> </xsl:text><xsl:value-of select="$type"/><xsl:value-of select="substring($rtype,1,1)"/><xsl:text> </xsl:text></span>
			</xsl:when>
			<xsl:otherwise><xsl:value-of select="wf"/></xsl:otherwise>	
	</xsl:choose>
  </span>
  &#160;
</xsl:template>

<xsl:template match="gloss"/>


</xsl:stylesheet>

