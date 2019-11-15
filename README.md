# Vuelve la revolución productiva

**Llueven inversiones, la producción nacional se reactiva, los precios ya no se mueven y nuestra modesta fábrica recibe tantos pedidos que no siempre llega a concretarlos.
Se quiere implementar un sistema de información para administrar la tarea, pero los expertos no se deciden por hacerlo en los términos del paradigma lógico o funcional, por lo que deciden prototipar dos versiones, una utilizando prolog y otra haskell, con funcionalidades similares.**

![](autos.jpg)
**Logico:** Se cuenta con información como la que se presenta en el archivo fabrica.pl

**Funcional:** Un avance en los tipos de datos elegidos, en el archivo fabrica.hs

### 1) Lo primero que se quiere saber es:
- los productos pedidos sin precio (x ej barco)
- los productos baratos, es decir de valor menor que el indicado (x ej, con 2000, moto y auto)
- los componentes que no son exclusivos, es decir que son usados para más de un producto (x ej rueda, motor)

**Logico:** Hacer los predicados que permitan averiguarlo.

**Funcional:** Hacer las funciones que recibiendo toda la información necesaria, permitan obtener lo solicitado como respuesta.

### 2) Además, se requiere ver la factibilidad de cumplir con los pedidos recibidos.
**Logico:** Relacionar a un cliente con un producto, en caso que se pueda fabricar un pedido del producto solicitado por dicho cliente, teniendo en cuenta que haya stock suficiente para sus componentes. Analizar la inversibilidad y ejemplificar con algunas consultas.

**Funcional:** A partir de todos los pedidos recibidos y de saber quién está a cargo de la fabrica en ese momento, encontrar aquellos que se puedan cumplir, teniendo en cuenta que quien está a cargo puede ser:

- vendedor de baratijas: Se fija que una unidad del producto a fabricar sea barata (el monto de referencia puede ser diferente para cada vendedor) 
- ingeniero de componentes: Se fija que la cantidad total de unidades necesarias de componentes sea menor a 100. 
- gerente vende humo: Siempre dice que se puede fabricar.
- inventar una nueva persona a cargo y que todo funcione sin tener que modificar lo hecho anteriormente

Justificar la utilización o no de los conceptos de orden superior, aplicación parcial y composición. Mostrar ejemplos de consulta y respuesta.
