import { Box, Button, Center, Heading, Text, VStack } from "@chakra-ui/react";
import React from "react";
import LinkButton from "../LinkButton/LinkButton";

function UnqiuenessCard(props) {
  let title = props.title;
  let description = props.description;
  let btnCaption = props.btnCaption;
  let btnHandler = props.btnHandler;
  let btnLink = props.btnLink;
  let bg = props.bg;

  return (
    <VStack
      padding={"20px"}
      bg={bg}
      height={"60vh"}
      width={"25vw"}
      minW={"300px"}
      color={"white"}
      border={"1px solid white"}
      borderRadius={"20px"}
      justify={"center"}
      spacing={5}
    >
      <Heading fontWeight={"700"} fontSize={"2rem"}>
        {title}
      </Heading>
      <Text height={"22vh"} fontSize={"1.2rem"}>
        {description}
      </Text>
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

export default UnqiuenessCard;
