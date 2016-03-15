defmodule ExPhoneNumber.Metadata.PhoneNumberDescription do
  defstruct national_number_pattern: nil, # string
            possible_number_pattern: nil, # string
            example_number: nil           # string

  import SweetXml
  alias ExPhoneNumber.Metadata.PhoneNumberDescription

  def from_xpath_node(xpath_node) do
    kwlist =
      xpath_node |> xmap(
        national_number_pattern: ~x"./nationalNumberPattern/text()"o |> transform_by(&normalize_string/1),
        possible_number_pattern: ~x"./possibleNumberPattern/text()"o |> transform_by(&normalize_string/1),
        example_number: ~x"./exampleNumber/text()"o |> transform_by(&normalize_string/1)
      )
    struct(%PhoneNumberDescription{}, kwlist)
  end

  defp normalize_string(nil), do: nil
  defp normalize_string(char_list) when is_list(char_list) do
    char_list
    |> List.to_string()
    |> String.split(["\n", " "], trim: true)
    |> List.to_string()
  end
end
