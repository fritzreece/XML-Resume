<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="address" mode="cityState">
		<xsl:choose>
			<xsl:when test="city">
				<xsl:value-of select="city"/>
				<xsl:if test="state">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="state"/>
				</xsl:if>
				<xsl:if test="(country) and not(state)">
					<xsl:text>, </xsl:text>
					<xsl:value-of select="country"/>
				</xsl:if>
			</xsl:when>
			<xsl:when test="state">
				<xsl:value-of select="state"/>
			</xsl:when>
			<xsl:when test="country">
				<xsl:value-of select="country"/>
			</xsl:when>
			<xsl:otherwise>
				<!-- should not be allowed -->
				<xsl:value-of select="normalize-space(.)"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>



	<xsl:template match="date" mode="monYear">
		<xsl:value-of select="substring(month,1,3)"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="year"/>
	</xsl:template>

	<xsl:template match="*" mode="commaList">
		<xsl:choose>
			<xsl:when test="position()=last()">
				<xsl:text>and </xsl:text><xsl:value-of select="."/><xsl:text>.</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="."/><xsl:text>, </xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="name">
		<xsl:value-of select="first"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="mi"/>
		<xsl:text>. </xsl:text>
		<xsl:value-of select="last"/>
	</xsl:template>

	<xsl:template match="name" mode="uppercase">	
		<xsl:variable name="lower" select="'qwertyuiopasdfghjklzxcvbnm'"/>
		<xsl:variable name="upper" select="'QWERTYUIOPASDFGHJKLZXCVBNM'"/>
		<xsl:value-of select="translate(first,$lower,$upper)"/>
		<xsl:text> </xsl:text>
		<xsl:value-of select="mi"/>
		<xsl:text>. </xsl:text>
		<xsl:value-of select="translate(last,$lower,$upper)"/>
	</xsl:template>
</xsl:stylesheet>