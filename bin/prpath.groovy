#!/usr/bin/env groovy
//    -*- Mode:java -*-

class PrPath
{
    def printPath( path )
    {
        def elements = path.split( ":" )

        for ( pathElement in elements )
        {
            println pathElement
        }
    }


    static void main( args )
    {
        def  printer = new PrPath()
        printer.run( args )
    }
 
 
    def void run( args )
    {
        if (  args.size() > 0  )
        {
            for ( arg in args )
            {
                printPath( arg  )
            }
        }
        else
        {
            printPath( "PATH" )
        }
    }
}
