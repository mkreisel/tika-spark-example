name := "tika-spark"

version := "1.0"

scalaVersion := "2.12.10"

libraryDependencies += "org.apache.spark" %% "spark-core" % "3.1.1" % "provided"
libraryDependencies += "org.apache.spark" %% "spark-sql" % "3.1.1" % "provided"
libraryDependencies += "com.thoughtworks.paranamer" % "paranamer" % "2.8"

Compile / packageBin / mainClass := Some("extract.TikaTest")