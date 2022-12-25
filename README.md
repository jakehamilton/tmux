# ✨ tmux Plus Ultra ✨

<a href="https://nixos.wiki/wiki/Flakes" target="_blank">
	<img alt="Nix Flakes Ready" src="https://img.shields.io/static/v1?logo=nixos&logoColor=d8dee9&label=Nix%20Flakes&labelColor=5e81ac&message=Ready&color=d8dee9&style=for-the-badge">
</a>
<a href="https://github.com/snowfallorg/lib" target="_blank">
	<img alt="Built With Snowfall" src="https://img.shields.io/static/v1?logoColor=d8dee9&label=Built%20With&labelColor=5e81ac&message=Snowfall&color=d8dee9&style=for-the-badge">
</a>

<p>
<!--
	This paragraph is not empty, it contains an em space (UTF-8 8195) on the next line in order
	to create a gap in the page.
-->
  
</p>

> Customized tmux, ready for development out of the box.

## Screenshots

![Clean](https://user-images.githubusercontent.com/7005773/194995518-dcf5fa69-458e-4ed3-a9a3-0c90e246f627.png)
![FZF](https://user-images.githubusercontent.com/7005773/194995575-2bc424c4-4b75-4096-b324-51887f48af72.png)
![Tiling Windows](https://user-images.githubusercontent.com/7005773/194995644-8a499ae5-742f-4458-831f-57c70eb15e10.png)

## Try Without Installing

You can try this configuration out without committing to installing it on your system by running
the following command.

```nix
nix run github:jakehamilton/tmux
```

## Install

### Nix Profile

You can install this package imperatively with the following command.

```nix
nix profile install github:jakehamilton/tmux
```

### Nix Configuration

You can install this package by adding it as an input to your Nix flake.

```nix
{
	description = "My system flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

		# Snowfall is not required, but will make configuration easier for you.
		snowfall-lib = {
			url = "github:snowfallorg/lib";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		tmux = {
			url = "github:jakehamilton/tmux";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
		inputs.snowfall-lib.mkFlake {
			inherit inputs;
			src = ./.;

			overlays = with inputs; [
				# Use the overlay provided by this flake.
				tmux.overlay

				# There is also a named overlay, though the output is the same.
				tmux.overlays."nixpkgs/plusultra"
			];
		};
}
```

If you've added the overlay from this flake, then in your system configuration
you can add the `plusultra.tmux` package.

```nix
{ pkgs }:

{
	environment.systemPackages = with pkgs; [
		plusultra.tmux
	];
}
```

## Lib

This flake exports a utility library for creating your own customized version of tmux.

### `lib.mkConfig`

Create a tmux configuration file.

Type: `Attrs -> Path`

Usage:

```nix
mkConfig {
	# You must pass through nixpkgs.
	inherit pkgs;

	# All other attributes are optional.
	shell = "${pkgs.bash}/bin/bash";

	plugins = with pkgs.tmuxPlugins; [
		nord
	];

	extra-config = ''
		set -g history-limit 1000
	'';
}
```

## Customization

The tmux package in this flake can be overriden to use a custom configuration. See the
following example for how to create your own derivation.

```nix
{
	description = "My tmux flake";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";

		# Snowfall is not required, but will make configuration easier for you.
		snowfall-lib = {
			url = "github:snowfallorg/lib";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		tmux = {
			url = "github:jakehamilton/tmux";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs:
		let
			lib = inputs.snowfall-lib.mkLib {
				inherit inputs;
				src = ./.;
			};
		in
		lib.mkFlake {
			outputs-builder = channels:
				let
					pkgs = channels.nixpkgs;
					inherit (inputs.tmux.packages.${pkgs.system}) tmux;
				in
				{
					packages.custom-tmux = tmux.override {
						tmux-config = lib.tmux.mkConfig {
							inherit pkgs;

							plugins = with pkgs.tmuxPlugins; [
								nord
								tilish
								tmux-fzf
							];

							extra-config = ''
								set -g history-limit 2000
							'';
						};
					};
				};
		};
}
```
