
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <link rel="stylesheet" href="CSS/estilosJSP.css">
        <link href="https://fonts.googleapis.com/css2?family=Share+Tech&display=swap" rel="stylesheet">
        <link rel="icon" href="IMAGENES/zapato.ico">

        <title>Zapatos - CalzadoFloridablanca</title>
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
                            <label>ID del Zapato</label>
                            <input type="text" class="form-control" placeholder="Digite aquí el zapatoID" ng-model="b1.zapatoID">
                        </div>
                        <div class="col-6">
                            <label>Tipo de Zapato</label>
                            <input type="text" class="form-control" placeholder="Digite aquí el Tipo de Zapato" ng-model="b1.tipoZapato">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Talla</label>
                            <input type="text" class="form-control" placeholder="Digite aquí la Talla del Zapato" ng-model="b1.talla" >
                        </div>
                        <div class="col-6">
                            <label>Material</label>
                            <input type="text" class="form-control" placeholder="Digite aquí el Tipo de Material" ng-model="b1.material">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>ID del Proveedor</label>                            
                            <select class="form-control" ng-model="b1.proveedorID"> 
                                <option ng-repeat="a in b1.Proveedores" value="{{a.proveedorID}}">{{a.nombre}} {{'-'}} {{'Ubicado en: '}} {{a.ciudad}}</option>
                            </select>
                        </div>
                        <div class="col-6">
                            <label>Cédula del Empleado</label>                            
                            <select class="form-control" ng-model="b1.cedulaEmpleado"> 
                                <option ng-repeat="c in b1.Empleados" value="{{c.cedula}}">{{'C:'}} {{c.cedula}} {{'-'}} {{c.nombre}} {{c.apellido}}</option>
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
            </div>
            <div class="row">
                <div class="col-12">
                    <table class="table">
                        <thead class="thead-dark">
                            <tr>
                                <th scope="col">Identificador Zapato</th>
                                <th scope="col">Tipo de Zapato</th>
                                <th scope="col">Talla del Zapato</th>
                                <th scope="col">Material del Zapato</th>
                                <th scope="col">ID del Proveedor</th>
                                <th scope="col">Empleado Responsable</th>
                                <th scope="col">Acciones</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat=" zap in b1.Zapatos">
                                <td>{{zap.zapatoID}}</td>
                                <td>{{zap.tipoZapato}}</td>
                                <td>{{zap.talla}}</td>
                                <td>{{zap.material}}</td>
                                <td>{{zap.proveedorID}}</td>
                                <td>{{zap.cedulaEmpleado}}</td>
                                <td>
                                    <button type="button" class="btn btn-info" ng-click="b1.editar(zap.zapatoID)">Editar</button>
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

                consultarProveedores = function () {
                    var parametros = {proceso: 'listar'};
                    $http({
                        method: 'POST',
                        url: 'peticionesProveedor.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Proveedores = res.data.Proveedores;
                    });
                };

                consultarEmpleados = function () {
                    var parametros = {proceso: 'listar'};
                    $http({
                        method: 'POST',
                        url: 'peticionesEmpleado.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Empleados = res.data.Empleados;
                    });
                };

                consultarEmpleados();
                consultarProveedores();

                b1.listar = function () {
                    var parametros = {
                        proceso: 'listar'
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesZapatos.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Zapatos = res.data.Zapatos;
                    });
                };


                b1.guardar = function () {
                    var parametros = {
                        proceso: 'guardar',
                        zapatoID: b1.zapatoID,
                        tipoZapato: b1.tipoZapato,
                        talla: b1.talla,
                        material: b1.material,
                        proveedorID: b1.proveedorID,
                        cedulaEmpleado: b1.cedulaEmpleado
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesZapatos.jsp',
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
                        zapatoID: b1.zapatoID,
                        tipoZapato: b1.tipoZapato,
                        talla: b1.talla,
                        material: b1.material,
                        proveedorID: b1.proveedorID,
                        cedulaEmpleado: b1.cedulaEmpleado
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesZapatos.jsp',
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
                        zapatoID: b1.zapatoID
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesZapatos.jsp',
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
                        zapatoID: id
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesZapatos.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.zapatoID = res.data.Zapato.zapatoID;
                        b1.tipoZapato = res.data.Zapato.tipoZapato;
                        b1.talla = res.data.Zapato.talla;
                        b1.material = res.data.Zapato.material;
                        b1.proveedorID = res.data.Zapato.proveedorID.toString();
                        b1.cedulaEmpleado = res.data.Zapato.cedulaEmpleado.toString();
                    });
                };
            }
            ;
        </script>
    </body>
</html>
