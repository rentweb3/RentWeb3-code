import { Box, Button, Center, Heading, Text, VStack } from "@chakra-ui/react";
import React from "react";
import LinkButton from "../LinkButton/LinkButton";

function ServiceCard(props) {
  let title = props.title;
  let description = props.description;
  let btnCaption = props.btnCaption;
  let btnHandler = props.btnHandler;
  let btnLink = props.btnLink;

  return (
    <VStack
      padding={"20px"}
      bg={"black"}
      height={"60vh"}
      width={"25vw"}
      minW={"300px"}
      color={"white"}
      border={"1px solid white"}
      borderRadius={"20px"}
      justify={"center"}
      spacing={5}
    >
      <Heading fontSize={"30px"}>{title}</Heading>
      <Text>{description}</Text>
      <Button
        colorScheme={"linkedin"}
        href={btnLink ? btnLink : null}
        onClick={btnHandler ? btnHandler : () => {}}
      >
        {btnCaption}
      </Button>
    </VStack>
  );
}

export default ServiceCard;
