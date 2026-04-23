<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!-- Indicamos que la salida será HTML -->
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Plantilla raíz: genera la estructura completa del HTML -->
  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <title>Inventario de Hardware de Red</title>
        <style>
          /* ── Estilos generales ── */
          body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f0f4f8;
            margin: 40px;
            color: #333;
          }

          h1 {
            text-align: center;
            color: #1a3c5e;
            font-size: 2rem;
            margin-bottom: 8px;
          }

          p.subtitulo {
            text-align: center;
            color: #555;
            margin-bottom: 30px;
            font-size: 0.95rem;
          }

          /* ── Tabla ── */
          table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
          }

          thead tr {
            background-color: #1a3c5e;
            color: #ffffff;
            text-align: left;
          }

          thead th {
            padding: 14px 18px;
            font-size: 0.9rem;
            letter-spacing: 0.05em;
            text-transform: uppercase;
          }

          tbody tr {
            border-bottom: 1px solid #e2e8f0;
            transition: background-color 0.2s;
          }

          tbody tr:hover {
            background-color: #ebf4ff;
          }

          tbody tr:last-child {
            border-bottom: none;
          }

          tbody td {
            padding: 13px 18px;
            font-size: 0.95rem;
          }

          /* Columna ID centrada */
          td.col-id, th.col-id {
            text-align: center;
            width: 60px;
          }

          /* Columna Precio alineada a la derecha */
          td.col-precio {
            text-align: right;
            font-weight: 600;
            color: #2b6cb0;
          }

          /* Pie de tabla */
          tfoot tr {
            background-color: #edf2f7;
          }

          tfoot td {
            padding: 12px 18px;
            font-size: 0.85rem;
            color: #666;
          }

          span.badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 0.78rem;
            font-weight: 600;
            color: #fff;
          }

          /* Colores por tipo de dispositivo */
          span.badge-router       { background-color: #3182ce; }
          span.badge-switch       { background-color: #38a169; }
          span.badge-servidor     { background-color: #805ad5; }
          span.badge-firewall     { background-color: #c53030; }
          span.badge-acceso       { background-color: #d69e2e; }
          span.badge-otro         { background-color: #718096; }
        </style>
      </head>
      <body>
        <h1>&#128187; Inventario de Hardware de Red</h1>
        <p class="subtitulo">Versión XML + XSL — Alumno A | Fase 3</p>

        <table>
          <thead>
            <tr>
              <th class="col-id">ID</th>
              <th>Tipo</th>
              <th>Marca</th>
              <th>Modelo</th>
              <th>Precio (€)</th>
            </tr>
          </thead>
          <tbody>
            <!-- Iteramos sobre cada <dispositivo> del XML -->
            <xsl:for-each select="inventario/dispositivo">
              <tr>
                <!-- ID -->
                <td class="col-id">
                  <xsl:value-of select="id"/>
                </td>

                <!-- Tipo con badge de color según categoría -->
                <td>
                  <xsl:choose>
                    <xsl:when test="tipo = 'Router'">
                      <span class="badge badge-router">
                        <xsl:value-of select="tipo"/>
                      </span>
                    </xsl:when>
                    <xsl:when test="tipo = 'Switch'">
                      <span class="badge badge-switch">
                        <xsl:value-of select="tipo"/>
                      </span>
                    </xsl:when>
                    <xsl:when test="tipo = 'Servidor'">
                      <span class="badge badge-servidor">
                        <xsl:value-of select="tipo"/>
                      </span>
                    </xsl:when>
                    <xsl:when test="tipo = 'Firewall'">
                      <span class="badge badge-firewall">
                        <xsl:value-of select="tipo"/>
                      </span>
                    </xsl:when>
                    <xsl:when test="tipo = 'Punto de Acceso'">
                      <span class="badge badge-acceso">
                        <xsl:value-of select="tipo"/>
                      </span>
                    </xsl:when>
                    <xsl:otherwise>
                      <span class="badge badge-otro">
                        <xsl:value-of select="tipo"/>
                      </span>
                    </xsl:otherwise>
                  </xsl:choose>
                </td>

                <!-- Marca -->
                <td>
                  <xsl:value-of select="marca"/>
                </td>

                <!-- Modelo -->
                <td>
                  <xsl:value-of select="modelo"/>
                </td>

                <!-- Precio formateado -->
                <td class="col-precio">
                  <xsl:value-of select="format-number(precio, '#.##0,00', 'europeo')"/>&#160;€
                </td>
              </tr>
            </xsl:for-each>
          </tbody>

          <tfoot>
            <tr>
              <td colspan="5">
                Total de dispositivos:&#160;
                <strong>
                  <xsl:value-of select="count(inventario/dispositivo)"/>
                </strong>
              </td>
            </tr>
          </tfoot>
        </table>

      </body>
    </html>
  </xsl:template>

  <!-- Definición del formato de número europeo (coma decimal, punto miles) -->
  <xsl:decimal-format name="europeo"
    decimal-separator=","
    grouping-separator="."/>

</xsl:stylesheet>
