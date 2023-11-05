module ReviewConfig exposing (config)

import Docs.NoMissing exposing (exposedModules, onlyExposed)
import Docs.ReviewAtDocs
import Docs.ReviewLinksAndSections
import Docs.UpToDateReadmeLinks
import NoBooleanCase
import NoDebug.Log
import NoDebug.TodoOrToString
import NoDeprecated
import NoImportingEverything
import NoLeftPizza
import NoMissingTypeAnnotation
import NoMissingTypeExpose
import NoPrematureLetComputation
import NoRedundantConcat
import NoRedundantCons
import NoSimpleLetBody
import NoUnsortedCases
import NoUnsortedLetDeclarations
import NoUnsortedRecords
import NoUnsortedTopLevelDeclarations
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import Review.Rule as Rule exposing (Rule)
import Simplify


config : List Rule
config =
    [ Docs.NoMissing.rule
        { document = onlyExposed
        , from = exposedModules
        }
    , Docs.ReviewLinksAndSections.rule
    , Docs.ReviewAtDocs.rule
    , Docs.UpToDateReadmeLinks.rule
    , NoBooleanCase.rule
    , NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
        |> Rule.ignoreErrorsForDirectories [ "tests/" ]
    , NoDeprecated.rule NoDeprecated.defaults
    , NoImportingEverything.rule []
    , NoLeftPizza.rule NoLeftPizza.Redundant
    , NoMissingTypeAnnotation.rule
    , NoMissingTypeExpose.rule
    , NoSimpleLetBody.rule
    , NoPrematureLetComputation.rule
    , NoRedundantConcat.rule
    , NoRedundantCons.rule
    , NoUnsortedCases.rule NoUnsortedCases.defaults
    , NoUnsortedLetDeclarations.rule
        (NoUnsortedLetDeclarations.sortLetDeclarations
            |> NoUnsortedLetDeclarations.alphabetically
        )
    , NoUnsortedRecords.rule
        (NoUnsortedRecords.defaults
            |> NoUnsortedRecords.reportAmbiguousRecordsWithoutFix
        )
    , NoUnsortedTopLevelDeclarations.rule
        (NoUnsortedTopLevelDeclarations.sortTopLevelDeclarations
            |> NoUnsortedTopLevelDeclarations.typesFirst
            |> NoUnsortedTopLevelDeclarations.portsFirst
            |> NoUnsortedTopLevelDeclarations.exposedOrderWithPrivateLast
            |> NoUnsortedTopLevelDeclarations.alphabetically
        )
    , NoUnused.Dependencies.rule
    , NoUnused.Modules.rule
    , NoUnused.Parameters.rule
    , NoUnused.Patterns.rule
    , NoUnused.Variables.rule
    , Simplify.rule Simplify.defaults
    ]
