import dash
import visdcc
import dash_core_components as dcc
import dash_html_components as html
from dash.dependencies import Input, Output, State
import plotly.express as px
import pandas as pd
from Connection import Connection
import Funciones as sql

external_stylesheets = ["https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css"]

# Inicializacion app dash
app = dash.Dash(__name__, external_stylesheets=external_stylesheets)


# Indice de ocupacion
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.Indice_ocupacion(), con.connection)
con.closeConnection()
dfCases = pd.DataFrame(query, columns=["booking_date", "indice_ocupacion"])
# Grafico de Linea
figLineIndice = px.line(dfCases, x="booking_date", y="indice_ocupacion")

# Indice de Gini
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.Gini(), con.connection)
con.closeConnection()
dfCases = pd.DataFrame(query, columns=["percent_host", "percent_prop"])
# Grafico barras
figLineGini = px.line(dfCases, x="percent_host", y="percent_prop")

# Conexiones User-Host
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.net(), con.connection)
con.closeConnection()
node_list = list(set(query['host_id_host'].unique().tolist() + \
                    query['id_user'].unique().tolist()))
nodes = [{'id': str(node_name), 'label': str(node_name), 'shape': 'dot', 'size': 7}
        for node_name in node_list]
edges = []
for row in query.to_dict(orient='records'):
    source, target = row['host_id_host'], row['id_user']
    edges.append({
        'id': str(source) + "__" + str(target),
        'from': str(source),
        'to': str(target),
        'width': 2,
    })

#Conexiones User_comment - Listing
con = Connection()
con.openConnection()
query = pd.read_sql_query(sql.net2(), con.connection)
con.closeConnection()
node_list2 = list(set(query['id_listings'].unique().tolist() + \
                    query['id_user'].unique().tolist()))
nodes2 = [{'id': str(node_name), 'label': str(node_name), 'shape': 'dot', 'size': 7}
        for node_name in node_list2]
edges2 = []
for row in query.to_dict(orient='records'):
    source, target = row['id_listings'], row['id_user']
    edges2.append({
        'id': str(source) + "__" + str(target),
        'from': str(source),
        'to': str(target),
        'width': 2,
    })

# Layout 
app.layout = html.Div(
    [
    html.H1(children='Escenarios de Analisis '),
    html.H2(children='Indice de ocupacion'),
    dcc.Graph(
        id='barCasesByCountry',
        figure=figLineIndice
    ),
    html.H2(children='Grado de desigualdad en el numero de propiedades'),
    dcc.Graph(
        id='figLineGini',
        figure=figLineGini
    ),
    html.H2(children='Conexiones entre usuarios y host'),
    visdcc.Network(id = 'net',
                    data ={'nodes': nodes, 'edges': edges},
                    options = dict(height = '600px', width = '100%')),
    html.H2(children='Conexiones entre usuarios que comentan y listings'),
    visdcc.Network(id = 'net2',
                   data ={'nodes': nodes2, 'edges': edges2},
                  options = dict(height = '600px', width = '100%'))
]
)

if __name__ == '__main__':
    app.run_server(debug=True)
