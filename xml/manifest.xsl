<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:ext="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings" xmlns:xls="http://www.w3.org/1999/XSL/Transform">
    <xsl:strip-space elements="*"/>

    <xsl:template match="/">
        <html>
            <head>
                <link href="https://fonts.googleapis.com/css?family=Roboto" rel="stylesheet"/>
                <link href="https://cdn.rawgit.com/loicfrance/xsl_doc/master/docStyle.css" rel="stylesheet"/>
<!--                <xsl:if test="doc/head">-->
<!--                    <xsl:copy-of select="doc/head"/>-->
<!--                </xsl:if>-->
            </head>
            <body>
                <!--
                ################################################################################
                ################################ external links ################################
                ################################################################################
                 -->
                <h1>Manifest details</h1>
                <xsl:if test="manifest/hash">
                    <h2>Versions info</h2>
                    <table>
                        <thead>
                            <tr>
                                <th>Section</th>
                                <th>Short</th>
                                <th>SHA-1</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Fileset</td>
                                <td><xsl:value-of select="manifest/hash/files/@short"/></td>
                                <td><xsl:value-of select="manifest/hash/files/@value"/></td>
                            </tr>
                            <tr>
                                <td>Generated groups</td>
                                <td><xsl:value-of select="manifest/hash/group/@short"/></td>
                                <td><xsl:value-of select="manifest/hash/group/@value"/></td>
                            </tr>
                            <tr>
                                <td>Chips associations</td>
                                <td><xsl:value-of select="manifest/hash/chips/@short"/></td>
                                <td><xsl:value-of select="manifest/hash/chips/@value"/></td>
                            </tr>
                        </tbody>
                    </table>
                </xsl:if>
                <h2>Generation infos</h2>
                <xsl:if test="manifest/fileset">
                    <h3>Fileset</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Family</th>
                                <th>Version</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="manifest/fileset/family">
                            <tr>
                                <th><xsl:value-of select="@name"/></th>
                                <th><xsl:value-of select="@version"/></th>
                            </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </xsl:if>
                <xsl:if test="manifest/groups">
                    <h3>Generated groups</h3>
                    <ul>
                        <xsl:for-each select="manifest/groups/group">
                            <li><xsl:value-of select="@name"/></li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
                <xsl:if test="manifest/chips">
                    <h3>Defines associations</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>Family</th>
                                <th>Define</th>
                                <th>Header</th>
                                <th>SVD file</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="manifest/chips/family">
                                <tr>
                                    <td><xsl:value-of select="@name"/></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <xsl:for-each select="chip">
                                    <tr>
                                        <td></td>
                                        <td><xsl:value-of select="@define"/></td>
                                        <td><xsl:value-of select="@header"/></td>
                                        <td><xsl:value-of select="@svd"/></td>
                                    </tr>
                                </xsl:for-each>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </xsl:if>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
