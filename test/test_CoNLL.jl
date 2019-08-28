using CorpusLoaders
using Test
using Base.Iterators
using MultiResolutionIterators

@testset "Basic use" begin
    train = load(CoNLL(), "train")
    test = load(CoNLL(), "test")
    dev = load(CoNLL(), "dev")

    @test length(train) > 0
    @test length(test) > 0
    @test length(dev) > 0
end

@testset "Using flatten_levels" begin
    train = load(CoNLL())
    docs = train[1:5]

    words = full_consolidate(flatten_levels(docs, (!lvls)(CoNLL, :word)))
    @test length(words) > length(docs)
    @test length(words) > sum(length.(docs))
    @test typeof(words) == Vector{CorpusLoaders.NERTaggedWord}

    plain_words = word.(words)
    @test typeof(plain_words) <: Vector{String}

    ner_tags = named_entity.(words)
    @test typeof(ner_tags) <: Vector{String}

    pos_tags = part_of_speech.(words)
    @test typeof(pos_tags) <: Vector{String}
end
