
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.9/angular.min.js"></script>
        <link rel="stylesheet" href="CSS/estilosJSP.css">
        <link href="https://fonts.googleapis.com/css2?family=Share+Tech&display=swap" rel="stylesheet">
        <link rel="icon" href="IMAGENES/avatar.ico">

        <title>Empleados - CalzadoFloridablanca</title>
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
                            <label>Cédula Empleado</label>
                            <input type="text" class="form-control" placeholder="Digite el número de la Cédula" ng-model="b1.cedula">
                        </div>
                        <div class="col-6">
                            <label>Nombre</label>
                            <input type="text" class="form-control" placeholder="Digite el Nombre del empleado" ng-model="b1.nombre">

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Número de Teléfono</label>
                            <input type="text" class="form-control" placeholder="Digite el Número telefónico" ng-model="b1.numero" >
                        </div>
                        <div class="col-6">
                            <label>Correo</label>
                            <input type="text" class="form-control" placeholder="Digite el Correo Electrónico" ng-model="b1.correo">
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <label>Salario</label>
                            <input type="text" class="form-control" placeholder="Digite el Salario Devengado" ng-model="b1.salario">
                        </div>
                        <div class="col-6">
                            <label>Fecha de Nacimiento</label>                            
                            <input type="text" class="form-control" placeholder="Digite la Fecha de Nacimiento" ng-model="b1.fechaNacimiento">
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
                                <th scope="col">Cédula Empleado</th>
                                <th scope="col">Nombre Empleado</th>
                                <th scope="col">Correo Empleado</th>
                                <th scope="col">Salario Devengado</th>
                                <th scope="col">Fecha De Nacimiento Empleado</th>
                                <th scope="col">Número Telefónico</th>
                                <th scope="col">Acciones</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat=" emp in b1.Empleados">
                                <td>{{emp.cedula}}</td>
                                <td>{{emp.nombre}}</td>
                                <td>{{emp.correo}}</td>
                                <td>{{emp.salario}}</td>
                                <td>{{emp.fechaNacimiento}}</td>
                                <td>{{emp.numero}}</td>
                                <td>
                                    <button type="button" class="btn btn-info" ng-click="b1.editar(emp.cedula)">Editar</button>
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
                        url: 'peticionesEmpleado.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.Empleados = res.data.Empleados;
                    });
                };

//                listar();

                b1.guardar = function () {
                    var parametros = {
                        proceso: 'guardar',
                        cedula: b1.cedula,
                        nombre: b1.nombre,
                        correo: b1.correo,
                        salario: b1.salario,
                        fechaNacimiento: b1.fechaNacimiento,
                        numero: b1.numero
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesEmpleado.jsp',
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
                        cedula: b1.cedula,
                        nombre: b1.nombre,
                        correo: b1.correo,
                        salario: b1.salario,
                        fechaNacimiento: b1.fechaNacimiento,
                        numero: b1.numero
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesEmpleado.jsp',
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
                        cedula: b1.cedula
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesEmpleado.jsp',
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
                        cedula: id
                    };
                    $http({
                        method: 'POST',
                        url: 'peticionesEmpleado.jsp',
                        params: parametros
                    }).then(function (res) {
                        b1.cedula = res.data.Empleado.cedula;
                        b1.nombre = res.data.Empleado.nombre;
                        b1.correo = res.data.Empleado.correo;
                        b1.salario = res.data.Empleado.salario;
                        b1.fechaNacimiento = res.data.Empleado.fechaNacimiento;
                        b1.numero = res.data.Empleado.numero;
                    });
                };
            }
            ;
        </script>
    </body>
</html>
