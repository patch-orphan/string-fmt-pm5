use Test::More tests => 24;

use ok 'String::Fmt', qw( fmt );

# L<S02/"Names and Variables"/"formatted representation"
#   of "any scalar value" "fmt(SCALAR, '%03d')">
{
    is fmt("Hi", "[%s]"), "[Hi]", 'fmt() works with %s';
    is fmt('3.141', "[%d]"), "[3]", "fmt() works with %d";
    is fmt(5.6, '%f'), '5.600000', 'fmt() works with %f';
    is fmt(\"Hi", "[%s]"), "[Hi]", 'fmt() works with scalar ref and %s';
    is fmt(\'3.141', "[%d]"), "[3]", "fmt() works with scalar ref and %d";
    is fmt(\5.6, '%f'), '5.600000', 'fmt() works with scalar ref and %f';
}

# L<S02/"Names and Variables"/"format an array value"
#   "supply a second argument">
{
    is fmt([1.3, 2.4, 3], "%d", "_"), "1_2_3", "fmt() works with plain lists";
    my @list = 'a'..'c';
    is fmt(\@list, '<%s>', ':'), '<a>:<b>:<c>', 'fmt() works with @ array';

    my $list = ['a', 'b', 'c'];
    is fmt($list, '[%s]', ','), '[a],[b],[c]', 'fmt() works with Array object';

    # single elem Array:
    $list = ['a'];
    is fmt($list, '<<%s>>', '!!!'), '<<a>>', 'fmt() works for single elem array';
}

# L<S02/"Names and Variables"/"hash value" "formats for both key and value">
{
    my $hash = {
        a => 1.3,
        b => 2.4,
    };
    my $str = fmt($hash, "%s:%d", "_");
    if ($str eq "a:1_b:2" || $str eq "b:2_a:1") {
        pass "fmt() works with hashes";
    } else {
        fail "fmt() fails to work with hashes";
    }
}

# L<S02/"Names and Variables"/"list of pairs" "formats for both key and value">
TODO: {
    local $TODO = 'fmt(ARRAY[HASH]) NYI';

    # a single pair:
    my $pair = {100 => 'lovely'};
    is fmt($pair, "%d ==> %s"), "100 ==> lovely", 'fmt() works with a single pair';

    # list of a single pair:
    my @pairs = {100 => 'lovely'};
    is fmt(\@pairs, "%d ==> %s", "\n"), "100 ==> lovely", 'fmt() works with lists of a single pair';

    # list of pair:
    @pairs = ({a => 1.3}, {b => 2.4});
    is fmt(\@pairs, "%s:%d", "_"), "a:1_b:2", "fmt() works with lists of pairs";
    is fmt(\@pairs, "(%s => %f)", ""), "(a => 1.3)(b => 2.4)",
        "fmt() works with lists of pairs";
}

# Test defaults on $comma
{
    is fmt([1..3], "%d"), "1 2 3", 'default $comma for array';

    my $hash = {
        a => 1.3,
        b => 2.4,
    };
    my $str = fmt($hash, "%s:%d");
    if ($str eq "a:1\nb:2" || $str eq "b:2\na:1") {
        pass 'default $comma works with hashes';
    } else {
        fail 'default $comma fails to work with hashes';
    }
}

# fmt() without arguments
{
    is fmt(1), '1', 'scalar fmt() without $fmt';
    is fmt({1=>"a"}), "1\ta", 'pair fmt() without $fmt';
    is fmt([1,2]), '1 2', 'list fmt() without $fmt';
    is fmt([1,2]), '1 2', 'array fmt() without $fmt';
    is fmt({1=>"a"}), "1\ta", 'hash fmt() without $fmt';
}

# fmt() with filehandle
{
    is fmt(\*DATA, "'%s'", ', '), "'a', 'b', 'c'", 'fmt() works with filehandle';
}

__DATA__
a
b
c
