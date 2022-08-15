<%-- 
    Document   : libros
    Created on : 22/07/2022, 1:01:18 p. m.
    Author     : CENTIC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <title>Libros</title>
        <style>
            div{
                border: dotted 2px;
            }
        </style>
    </head>
    <body>
        <div class="container-fluid" style="background: background" ng-app="demoB1" ng-controller="b1Controller as b1" >
            <div class="row">
                <div class="col-6">
                    <h3>Seccion 1</h3>
                    <div class="row">
                        <div class="col-6"> 
                            <label>ISBN</label>
                            <input type="text" class="form-control" placeholder="ISBN" ng-model="b1.isbn">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" placeholder="nombre" ng-model="b1.nombre">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6"><label>numero de paginas</label>
                            <input type="text" class="form-control" placeholder="numero de paginas" ng-model="b1.numeroDePaginas" >
                        </div>
                        <div class="col-6">
                            <label>Año</label>
                            <input type="text" class="form-control" placeholder="Año" ng-model="b1.annio">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Codigo autor</label>
                            <!--<input type="text" class="form-control" placeholder="Codigo autor" ng-model="b1.codigoAutor">-->
                            <select class="form-control" ng-model="b1.codigoAutor"> 
                                <option ng-repeat="a in b1.Autores" value="{{a.codigo}}">{{a.nombre}}</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label>id categoria</label>
                            <!--<input type="text" class="form-control" placeholder="id categoria" ng-model="b1.idCategoria">-->
                            <select class="form-control" ng-model="b1.idCategoria"> 
                                <option ng-repeat="c in b1.Categorias" value="{{c.idCategoria}}">{{c.nombre}}</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-3"><button type="button" class="btn btn-success" ng-click="b1.guardar()">Guardar</button></div>
                        <div class="col-3"><button type="button" class="btn btn-primary" ng-click="b1.listar()">Consultar</button></div>
                        <div class="col-3"><button type="button" class="btn btn-warning" ng-click="b1.actualizar()">Actualizar</button></div>
                        <div class="col-3"><button type="button" class="btn btn-danger" ng-click="b1.eliminar()">Eliminar</button></div>
                    </div>

                </div>
                <div class="col-6">
                    <h3>Seccion 2</h3>
                    <div class="row">
                        <div class="col-6"> 
                            <label>ISBN</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.isbn}}">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.nombre}}">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6"><label>numero de paginas</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.numeroDePaginas}}">
                        </div>
                        <div class="col-6">
                            <label>Año</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.annio}}">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Codigo autor</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.codigoAutor}}">
                        </div>
                        <div class="col-6">
                            <label>id categoria</label>
                            <input type="text" class="form-control" disabled="true" value="{{b1.idCategoria}}">
                        </div>
                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Isbn</th>
                                <th scope="col">Nombre</th>
                                <th scope="col"># pag</th>
                                <th scope="col">Año</th>
                                <th scope="col">Codigo Autot</th>
                                <th scope="col">idCategoria</th>
                                <th scope="col">Acciones</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat=" lib in b1.Libros">
                                <td>{{lib.isbn}}</td>
                                <td>{{lib.nombre}}</td>
                                <td>{{lib.numeroDePaginas}}</td>
                                <td>{{lib.annio}}</td>
                                <td>{{lib.autor}}</td>
                                <td>{{lib.categoria}}</td>
                                <td>
                                    <button type="button" class="btn btn-info" ng-click="b1.editar(lib.isbn)">Editar</button>
                                </td>
                            </tr>

                        </tbody>
                    </table>



                </div>
            </div>
        </div>

        <script>
            var app = angular.module('demoB1', []);
            app.controller('b1Controller', ['$http', controladorB1]);
            function controladorB1($http) {
                var b1 = this;
                consultarCategorias = function () {
                    var parametros = {proceso: 'listar'};
                    $http({
                        method: 'POST',
                        url: 'peticionesCategoria.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Categorias = res.data.Categorias;
                    });
                };
                consultarAutores = function () {
                    var parametros = {proceso: 'listar'};
                    $http({
                        method: 'POST',
                        url: 'peticionesAutor.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Autores = res.data.Autores;
                    });
                };
                consultarAutores();
                consultarCategorias();
                b1.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Libros = res.data.Libros;
                    });
                };
                b1.guardar = function () {
                    var parametros = {
                        proceso: 'guardar',
                        isbn: b1.isbn,
                        nombre: b1.nombre,
                        numeroDePaginas: b1.numeroDePaginas,
                        annio: b1.annio,
                        codigoAutor: b1.codigoAutor,
                        idCategoria: b1.idCategoria
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.guardar === true) {
                                alert('Guardó');
                            } else {
                                alert('No Guardó');
                            }

                        } else {
                            alert(res.data.errorMsg);
                        }
                    });

                };
                b1.actualizar = function () {
                    var parametros = {
                        proceso: 'actualizar',
                        isbn: b1.isbn,
                        nombre: b1.nombre,
                        numeroDePaginas: b1.numeroDePaginas,
                        annio: b1.annio,
                        codigoAutor: b1.codigoAutor,
                        idCategoria: b1.idCategoria
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.actualizar === true) {
                                alert('Actualizó');
                            } else {
                                alert('No actualizo');
                            }

                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };
                b1.eliminar = function () {
                    var parametros = {
                        proceso: 'eliminar',
                        isbn: b1.isbn

                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.eliminar === true) {
                                alert('Elimino');
                            } else {
                                alert('No elimino');
                            }

                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };
                b1.editar = function (id) {
                    var parametros = {
                        proceso: 'listarporid',
                        isbn: id
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesLibro.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.isbn = res.data.Libro.isbn;
                        b1.nombre = res.data.Libro.nombre;
                        b1.numeroDePaginas = res.data.Libro.numeroDePaginas;
                        b1.annio = res.data.Libro.annio;
                        b1.idCategoria = res.data.Libro.idCategoria.toString();
                        b1.codigoAutor = res.data.Libro.codigoAutor;

                    });
                };
            };
        </script>
    </body>
</html>
