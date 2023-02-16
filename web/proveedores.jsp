
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <link rel="stylesheet" href="css/style.css">
        <link href="https://fonts.googleapis.com/css2?family=Share+Tech&display=swap" rel="stylesheet">
        <link rel="icon" href="imagenes/proveedor.ico">        

        <title>Proveedores - CalzadoFloridablanca</title>
    </head>
    <body>
        <nav>
            <span class="logo" style="color: #ffffff;">CALZADO FLORIDABLANCA</span>
            <ul>
                <li><a href="index.html" style="text-decoration:none;color: #ffffff;">INICIO</a></li>
                <li><a href="zapatos.jsp" style="text-decoration:none;color: #ffffff">ZAPATOS</a></li>
                <li><a href="empleados.jsp" style="text-decoration:none;color: #ffffff">EMPLEADOS</a></li>
                <li><a href="proveedores.jsp" style="text-decoration:none;color: #ffffff">PROVEEDORES</a></li>
            </ul>
        </nav>

        <div class="container-fluid" style="background: background" ng-app="demoB1" ng-controller="b1Controller as b1" >
            <div class="row" style="padding-bottom: 25px">
                <div class="col-12">
                    <div>
                        <h1 class="font-weight-bold text-center" style="padding: 50px">SECCIÓN PARA EDITAR LOS PROVEEDORES</h1>
                        <h3 style="padding: 5px">
                            A continuación encontrará un menú para hacer las respectivas modificaciones a los proveedores de Calzado Floridablanca.
                            Si desea consultar los proveedores de la empresa, oprima el botón CONSULTAR.
                            Si desea inscribir un proveedor, rellene los datos y oprima el botón GUARDAR.
                            Si desea modificar los datos de un proveedor, primero liste con el botón CONSULTAR, busque el proveedor deseado y oprima el botón EDITAR.
                            Inmediatamente se proyectará la información en los campos superiores. Cambie la información y oprima el botón ACTUALIZAR.
                            Para eliminar un registro, realice los pasos anteriores y finalmente oprima el botón ELIMINAR.
                        </h3>
                    </div>

                    <div>
                        <div class="row" style="background-color: #5f9; padding: 25px">
                            <div class="col-6"> 
                                <h4>ID del Proveedor</h4>
                                <input type="text" class="form-control" placeholder="Digite aquí el ID del Proveedor" ng-model="b1.proveedorID">
                            </div>
                            <div class="col-6">
                                <h4>Nombre</h4>
                                <input type="text" class="form-control" placeholder="Digite aquí el Nombre de la Empresa" ng-model="b1.nombre">

                            </div>
                        </div>
                        <div class="row" style="background-color: #5f9; padding: 25px">
                            <div class="col-6">
                                <h4>Ciudad</h4>
                                <input type="text" class="form-control" placeholder="Digite aquí la Ciudad Origen de la Empresa" ng-model="b1.ciudad" >
                            </div>
                            <div class="col-6">
                                <h4>Teléfono</h4>
                                <input type="text" class="form-control" placeholder="Digite aquí el Teléfono de la Empresa" ng-model="b1.telefono">
                            </div>
                        </div>

                        <div>

                        </div>
                        <div class="row" style="background-color: #5f9; padding-bottom: 15px">
                            <div class="col-3 text-center"><button type="button" class="btn btn-success btn-lg" ng-click="b1.guardar()">GUARDAR</button></div>
                            <div class="col-3 text-center"><button type="button" class="btn btn-primary btn-lg" ng-click="b1.listar()">CONSULTAR</button></div>
                            <div class="col-3 text-center"><button type="button" class="btn btn-warning btn-lg" ng-click="b1.actualizar()">ACTUALIZAR</button></div>
                            <div class="col-3 text-center"><button type="button" class="btn btn-danger btn-lg" ng-click="b1.eliminar()">ELIMINAR</button></div>
                        </div>
                    </div>

                </div>               
            </div>
            <div class="row" style="background-color: #AEF5F3; padding-top: 25px">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th class="text-center" scope="col">ID del Proveedor</th>
                                <th class="text-center" scope="col">Nombre</th>
                                <th class="text-center" scope="col">Ciudad</th>
                                <th class="text-center" scope="col">Telefono</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody style="background-color: #fff;">
                            <tr ng-repeat="pro in b1.Proveedor">
                                <td class="text-center">{{pro.proveedorID}}</td>
                                <td class="text-center">{{pro.nombre}}</td>
                                <td class="text-center">{{pro.ciudad}}</td>
                                <td class="text-center">{{pro.telefono}}</td>
                                <td>
                                    <button type="button" class="btn btn-info btn-lg" ng-click="b1.editar(pro.proveedorID)">EDITAR</button>
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
