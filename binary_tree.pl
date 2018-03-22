package BinaryTree;
use v5.10;
use Moose;

has 'val' => (is => 'rw', isa => 'Int');

has 'parent' => (
	is        => 'rw',
	isa       => 'BinaryTree',
	predicate => 'has_parent',
	weak_ref  => 1,
);

has 'left' => (
	is        => 'rw',
	isa       => 'BinaryTree',
	predicate => 'has_left',
	lazy      => 1,
	builder   => '_build_child_tree',
);

has 'right' => (
	is        => 'rw',
	isa       => 'BinaryTree',
	predicate => 'has_right',
	lazy      => 1,
	builder   => '_build_child_tree',
);

before 'right', 'left' => sub {
	my ($self, $tree) = @_;
	$tree->parent($self) if defined $tree;
};

sub _build_child_tree {
	my $self = shift;
	return BinaryTree->new( parent => $self );
}

sub traverse {
	my $self = shift;
	if ( $self ) {
		say $self->val();
	}
	if ( $self->has_left ){
		traverse( $self->left());
        }
	if ( $self->has_right ) {
		traverse( $self->right());
	}
}

package main;
use Data::Dumper;
use Data::TreeDumper;

use constant { 
	SUM => 22
};

sub traverse {
	my $root = shift;
	our @stack;

	if ( $root->val() ) {
		push @stack, $root->val();
	}

	if ( $root->has_left ) {
		traverse( $root->left());
	}

	if ( $root->has_right ) {
		traverse( $root->right());
	}

	if ( &sum(@stack) == SUM ) {
	        say "[ @stack ]", " => ", SUM, " Matched!";
	} else {
		say "[ @stack ]", " => ", &sum(@stack);
	}
	pop @stack;
}

sub sum {
	my $sum = 0;
	map { $sum += $_ } @_;
	return $sum;
}

# Initializataion

my $tree = BinaryTree->new(val => 5);

$tree->left->val(4);
$tree->left->left->val(11);
$tree->left->left->left->val(7);
$tree->left->left->right->val(2);
$tree->right->val(8);
$tree->right->left->val(13);
$tree->right->left->left->val(6);
$tree->right->left->right->val(3);
$tree->right->right->val(4);
$tree->right->right->right->val(5);
$tree->right->right->left->val(1);


traverse($tree);


