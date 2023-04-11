# PostgreSQL Data Types
* PostgreSQL provides several datatypes that are used to define the type of data that can be stored in a column of a table.

## Commonly used datatypes in PostgreSQL
* **Numeric** data types are used to store numbers. There are several different numeric data types available, each with its own range and precision. The most common numeric data types are:
    * **integer** - Stores whole numbers from -2147483648 to 2147483647.
    * **bigint** - Stores whole numbers from -9223372036854775808 to 9223372036854775807.
    * **numeric** - Stores numbers with a fixed number of decimal places. For example, numeric(5,2) can store numbers from -9999.99 to 9999.99.
    * **decimal** - Stores numbers with a variable number of decimal places.
    * **money** - Stores monetary values.
    * **smallmoney** - Stores monetary values with less precision than money.
* **Date and Time** data types are used to store dates and times. The most common date and time data types are:
    * **date** - Stores a date in the format YYYY-MM-DD.
    * **time** - Stores a time in the format HH:MM:SS.
    * **timestamp** - Stores a timestamp, which is a combination of a date and time.
    * **timestamptz** - Stores a timestamp with a time zone.
    * **interval** - Stores an interval of time.
* **String** data types are used to store text. The most common string data types are:
    * **char** - Stores a fixed-length string. For example, char(5) can store a string of up to 5 characters.
    * **varchar** - Stores a variable-length string.
    * **text** - Stores a large text string.
* **Binary Data Types** are used to store binary data, such as images or files. The most common binary data types are:
    * **bytea** - Stores a binary string.
    * **uuid** - Stores a Universally Unique Identifier (UUID).
* **Additional Data types**
    * **boolean** - Stores a Boolean value, either true or false.
    * **json** - Stores JSON data.
    * **hstore** - Stores key-value pairs.
    * **array** - Stores an array of values.
    * **user-defined types** - Allows users to create their own data types.