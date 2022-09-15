
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <link rel="stylesheet" href="CSS/estilosJSP.css">
        <link href="https://fonts.googleapis.com/css2?family=Share+Tech&display=swap" rel="stylesheet">
        <link rel="icon" href="IMAGENES/proveedor.ico">        
        <title>Proveedores - CalzadoFloridablanca</title>
    </head>
    <body>
        <nav>
            <span class="logo">CALZADO FLORIDABLANCA</span>
            <ul>
                <li><a href="index.html" style="text-decoration:none">INICIO</a></li>
                <li><a href="zapatos.jsp" style="text-decoration:none">ZAPATOS</a></li>
                <li><a href="empleados.jsp" style="text-decoration:none">EMPLEADOS</a></li>
                <li><a href="proveedores.jsp" style="text-decoration:none">PROVEEDORES</a></li>
            </ul>
        </nav>   
        <div class="container-fluid" style="background: background" ng-app="demoB1" ng-controller="b1Controller as b1" >
            <div class="row">
                <div class="col-12">
                    <h3>Seccion 1</h3>
                    <div class="row">
                        <div class="col-6"> 
                            <label>ID del Proveedor</label>
                            <input type="text" class="form-control" placeholder="Digite aquí el ID del Proveedor" ng-model="b1.proveedorID">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" placeholder="Digite aquí el Nombre de la Empresa" ng-model="b1.nombre">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Ciudad</label>
                            <input type="text" class="form-control" placeholder="Digite aquí la Ciudad Origen de la Empresa" ng-model="b1.ciudad" >
                        </div>
                        <div class="col-6">
                            <label>Teléfono</label>
                            <input type="text" class="form-control" placeholder="Digite aquí el Teléfono de la Empresa" ng-model="b1.telefono">
                        </div>
                    </div>

                    <div>

                    </div>
                    <div class="row">
                        <div class="col-3"><button type="button" class="btn btn-success" ng-click="b1.guardar()">Guardar</button></div>
                        <div class="col-3"><button type="button" class="btn btn-primary" ng-click="b1.listar()">Consultar</button></div>
                        <div class="col-3"><button type="button" class="btn btn-warning" ng-click="b1.actualizar()">Actualizar</button></div>
                        <div class="col-3"><button type="button" class="btn btn-danger" ng-click="b1.eliminar()">Eliminar</button></div>
                    </div>
                </div>               
            </div>
            <div class="row">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">ID del Proveedor</th>
                                <th scope="col">Nombre</th>
                                <th scope="col">Ciudad</th>
                                <th scope="col">Telefono</th>
                                <th scope="col">Acciones</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="pro in b1.Proveedor">
                                <td>{{pro.proveedorID}}</td>
                                <td>{{pro.nombre}}</td>
                                <td>{{pro.ciudad}}</td>
                                <td>{{pro.telefono}}</td>
                                <td>
                                    <button type="button" class="btn btn-info" ng-click="b1.editar(pro.proveedorID)">Editar</button>
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

                b1.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesProveedor.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Proveedor = res.data.Proveedores;
                    });
                };


                b1.guardar = function () {
                    var parametros = {
                        proceso: 'guardar',
                        proveedorID: b1.proveedorID,
                        nombre: b1.nombre,
                        ciudad: b1.ciudad,
                        telefono: b1.telefono
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesProveedor.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.guardar === true) {
                                alert('Guardado Exitoso. Actualice la página para visualizar los cambios.');
                            } else {
                                alert('Hubo un error, no se guardó correctamente');
                            }
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });

                };

                b1.actualizar = function () {
                    var parametros = {
                        proceso: 'actualizar',
                        proveedorID: b1.proveedorID,
                        nombre: b1.nombre,
                        ciudad: b1.ciudad,
                        telefono: b1.telefono
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesProveedor.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.actualizar === true) {
                                alert('Actualización Exitosa. Actualice la página para visualizar los cambios.');
                            } else {
                                alert('Hubo un error, no se actualizó correctamente');
                            }
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };

                b1.eliminar = function () {
                    var parametros = {
                        proceso: 'eliminar',
                        proveedorID: b1.proveedorID
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesProveedor.jsp',
                        params: parametros
                    }).then(function (res) {
                        if (res.data.ok === true) {
                            if (res.data.eliminar === true) {
                                alert('Eliminación Exitosa. Actualice la página para visualizar los cambios.');
                            } else {
                                alert('Hubo un error, no se eliminó correctamente');
                            }
                        } else {
                            alert(res.data.errorMsg);
                        }
                    });
                };

                b1.editar = function (id) {
                    var parametros = {
                        proceso: 'ListarPorID',
                        proveedorID: id
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesProveedor.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.proveedorID = res.data.Proveedor.proveedorID;
                        b1.nombre = res.data.Proveedor.nombre;
                        b1.ciudad = res.data.Proveedor.ciudad;
                        b1.telefono = res.data.Proveedor.telefono;
                    });
                };
            }
            ;
        </script>
    </body>
</html>
