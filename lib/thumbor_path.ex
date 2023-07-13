defmodule ThumborPath do
  @moduledoc """
  Documentation for `ThumborPath`.
  """
  alias ThumborPath.Encoder
  alias ThumborPath.Parser

  defstruct hmac: :unsafe,
            meta: false,
            trim: nil,
            crop: nil,
            fit: :default,
            size: nil,
            horizontal_align: nil,
            vertical_align: nil,
            smart: false,
            filters: [],
            source: nil

  @type t :: %__MODULE__{
          hmac: :unsafe | hmac,
          meta: boolean,
          trim: nil | :top_left | :bottom_right,
          crop: nil | {crop_coordinates, crop_coordinates},
          fit: :default | {:fit, [:adaptive | :full]},
          size: nil | {size_coordinate, size_coordinate},
          horizontal_align: nil | :left | :center | :right,
          vertical_align: nil | :top | :middle | :left,
          smart: boolean(),
          filters: [binary()],
          source: Path.t()
        }

  @type hmac :: <<_::176>>
  @type crop_coordinates :: {non_neg_integer(), non_neg_integer()}
  @type size_coordinate :: integer() | nil | :orig

  @spec encode(t) :: Path.t()
  def encode(%__MODULE__{} = uri) do
    Encoder.encode(uri)
  end

  @spec parse(Path.t()) :: t()
  def parse(path) do
    Parser.parse(path)
  end

  @spec valid?(t | Path.t(), nil | binary()) :: boolean()
  def valid?(%__MODULE__{hmac: :unsafe}, nil), do: true
  def valid?(%__MODULE__{hmac: :unsafe}, _), do: false

  def valid?(%__MODULE__{} = uri, secret) do
    [hmac | _] = Encoder.build(uri, secret) |> Path.split()
    hmac == uri.hmac
  end

  def valid?(path, secret) when is_binary(path) do
    [hmac_given | rest] = path |> Path.relative() |> Path.split()

    if hmac_given == "unsafe" do
      secret == nil
    else
      hmac_computed = Encoder.signature(Path.join(rest), secret)
      hmac_given == hmac_computed
    end
  end
end
