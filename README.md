CSV Validator
=============

A Validation Tool and APIs for validating CSV (Comma Separated Value) files by using [CSV Schema](https://github.com/digital-preservation/csv-schema).

[![CI](https://github.com/digital-preservation/csv-validator/workflows/CI/badge.svg)](https://github.com/digital-preservation/csv-validator/actions?query=workflow%3ACI)

Released under the [Mozilla Public Licence version 2.0](http://www.mozilla.org/MPL/2.0/).

A [comprehensive user guide is available in GitHub pages](http://digital-preservation.github.io/csv-validator/), along with a more [complete specification of the CSV Schema language](http://digital-preservation.github.io/csv-schema/csv-schema-1.1.html).


Technology
----------
The Validation tool and APIs are written in Scala 2.13 and may be used as:

* A stand-alone command line tool.

* A desktop tool, we provide a simple Swing GUI.

* A library in your Scala project.

* A library in your Java project (We provide a Java 8 interface, to make things simple for Java programmers too).

The Validation Tool and APIs can be used on any Java Virtual Machine which supports Java 8 or better (**NB Java 6 support was removed in version 1.1**). The source code is
built using the [Apache Maven](https://maven.apache.org/) build tool:

1. For use in other Java/Scala Applications, build by executing `mvn clean install`.
2. For the Command Line Interface or Swing GUI, build by executing `mvn clean package`.
3. For the Docker image (`nationalarchives/csv-validator:latest`), build by executing `mvn clean package -Pdocker`.


Maven Artifacts
===============
Released Maven Artifacts can be found in Maven Central under the groupId [`uk.gov.nationalarchives`](http://search.maven.org/#search%7Cga%7C1%7Cg%3A%22uk.gov.nationalarchives%22).


Java API
--------
If you wish to use the CSV Validator from your own Java project, we provide a native Java API, the dependency details are:
```xml
<dependency>
	<groupId>uk.gov.nationalarchives</groupId>
    <artifactId>csv-validator-java-api</artifactId>
    <version>1.2-RC4</version>
</dependency>
```

The Javadoc, can be found in either Maven Central or you can build it locally by executing `mvn javadoc:javadoc`.

Example Java code of using the CSV Validator through the Java API:
```java
Boolean failFast = false;
List<Substitution> pathSubstitutions = new ArrayList<Substitution>();

List<FailMessage> messages = CsvValidator.validate(
"/data/csv/data.csv",
"/data/csv/data-schema.csvs",
failFast,
pathSubstitutions,
true,
false);

 if(messages.isEmpty()) {
	System.out.println("Completed validation OK");
 } else {
 	for(FailMessage message : messages) {
 		if(message instanceof WarningMessage) {
 			System.out.println("[WARN] " + message.getMessage());
 		} else {
 			System.out.println("[ERROR] " + message.getMessage());
 		}
 	}
}
```


Scala API
=========
Likewise, if you wish to use the CSV Validator from your own Scala project, the Scala API is part of the core, the dependency details are:
```xml
<dependency>
	<groupId>uk.gov.nationalarchives</groupId>
    <artifactId>csv-validator-core</artifactId>
    <version>1.2-RC4</version>
</dependency>
```

The Scaladoc, can be found in either Maven Central or you can build it locally by executing `mvn scala:doc`.

An example of using the Scala API can be found in the class `uk.gov.nationalarchives.csv.validator.api.java.CsvValidatorJavaBridge` from the
`csv-validator-java-api` module. The Scala API at present gives much more control over the individual Schema Parsing and Validation Processor
than the Java API.

Docker Container (of CSV Validator Command Line Tool)
=====================================================
To see the options run:
```bash
docker run nationalarchives/csv-validator
```

Then for example, to validate `/tmp/my-data.csv` with `/tmp/my-schema.csvs` you would run:
```bash
docker run nationalarchives/csv-validator /tmp/my-data.csv /tmp/my-schema.csvs
```

Schema Examples
===============
Examples of CSV Schema can be found in the test cases of the `csv-validator-core` module. See the `*.csvs` files in [acceptance/](https://github.com/digital-preservation/csv-validator/tree/master/csv-validator-core/src/test/resources/uk/gov/nationalarchives/csv/validator/acceptance). Schemas used by the Digital Preservation department at The National Archives are also available in the `example-schemas` folder of the [csv-schema](https://github.com/digital-preservation/csv-schema) repository.


Current Limitations of the CSV Validator Tool
=============================================
The CSV Validator implements almost all of `CSV Schema 1.1` language, current limitations and missing functionality are:

* `DateExpr` is not yet fully implemented (may raise Schema check error).

* `PartialDateExpr` is not yet implemented (raises Schema check error).

* At least `MD5`, `SHA-1`, `SHA-2`, `SHA-3`, and `SHA-256` checksum algorithms are supported. Probably many more as well as we defer to Java's `java.security.MessageDigest` class.
